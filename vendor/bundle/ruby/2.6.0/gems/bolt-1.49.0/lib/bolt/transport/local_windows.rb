# frozen_string_literal: true

require 'json'
require 'fileutils'
require 'open3'
require 'tmpdir'
require 'bolt/node/output'
require 'bolt/transport/base'
require 'bolt/transport/powershell'
require 'bolt/util'

module Bolt
  module Transport
    class LocalWindows < Base
      OPTIONS = {
        "interpreters"   => "A map of an extension name to the absolute path of an executable, "\
                            "enabling you to override the shebang defined in a task executable. The "\
                            "extension can optionally be specified with the `.` character (`.py` and "\
                            "`py` both map to a task executable `task.py`) and the extension is case "\
                            "sensitive. When a target's name is `localhost`, Ruby tasks run with the "\
                            "Bolt Ruby interpreter by default.",
        "run-as"         => "A different user to run commands as after login.",
        "run-as-command" => "The command to elevate permissions. Bolt appends the user and command "\
                            "strings to the configured `run-as-command` before running it on the target. "\
                            "This command must not require an interactive password prompt, and the "\
                            "`sudo-password` option is ignored when `run-as-command` is specified. The "\
                            "`run-as-command` must be specified as an array.",
        "sudo-password"  => "Password to use when changing users via `run-as`.",
        "tmpdir"         => "The directory to copy and execute temporary files."
      }.freeze

      def self.options
        OPTIONS.keys
      end

      def provided_features
        ['powershell']
      end

      def default_input_method(executable)
        input_method ||= Powershell.powershell_file?(executable) ? 'powershell' : 'both'
        input_method
      end

      def self.validate(options)
        logger = Logging.logger[self]
        if options['sudo-password'] || options['run-as'] || options['run-as-command'] || options[:run_as]
          logger.warn("run-as is not supported for Windows hosts using the local transport")
        end
      end

      def in_tmpdir(base)
        args = base ? [nil, base] : []
        dir = begin
                Dir.mktmpdir(*args)
              rescue StandardError => e
                raise Bolt::Node::FileError.new("Could not make tempdir: #{e.message}", 'TEMPDIR_ERROR')
              end

        yield dir
      ensure
        FileUtils.remove_entry dir if dir
      end
      private :in_tmpdir

      def copy_file(source, destination)
        logger.debug { "Uploading #{source}, to #{destination}" }
        FileUtils.cp_r(source, destination, remove_destination: true)
      rescue StandardError => e
        raise Bolt::Node::FileError.new(e.message, 'WRITE_ERROR')
      end

      def with_tmpscript(script, base)
        in_tmpdir(base) do |dir|
          dest = File.join(dir, File.basename(script))
          copy_file(script, dest)
          File.chmod(0o750, dest)
          yield dest, dir
        end
      end
      private :with_tmpscript

      def execute(*command, options)
        # Interpreter can be an array or string. It will be appended to the command array.
        command.unshift(options[:interpreter]).flatten! if options[:interpreter]
        command = [options[:env]] + command if options[:env]

        if options[:stdin]
          stdout, stderr, rc = Open3.capture3(*command, stdin_data: options[:stdin], chdir: options[:dir])
        else
          stdout, stderr, rc = Open3.capture3(*command, chdir: options[:dir])
        end

        result_output = Bolt::Node::Output.new
        result_output.stdout << stdout unless stdout.nil?
        result_output.stderr << stderr unless stderr.nil?
        result_output.exit_code = rc.exitstatus
        result_output
      end

      def upload(target, source, destination, options = {})
        self.class.validate(options)
        copy_file(source, destination)
        Bolt::Result.for_upload(target, source, destination)
      end

      def run_command(target, command, options = {})
        self.class.validate(options)
        in_tmpdir(target.options['tmpdir']) do |dir|
          output = execute(command, dir: dir)
          Bolt::Result.for_command(target,
                                   output.stdout.string,
                                   output.stderr.string,
                                   output.exit_code,
                                   'command', command)
        end
      end

      def run_script(target, script, arguments, options = {})
        self.class.validate(options)
        with_tmpscript(File.absolute_path(script), target.options['tmpdir']) do |file, dir|
          logger.debug "Running '#{file}' with #{arguments.to_json}"

          # unpack any Sensitive data AFTER we log
          arguments = unwrap_sensitive_args(arguments)
          if Powershell.powershell_file?(file)
            command = Powershell.run_script(arguments, file)
            interpreter = ['powershell.exe', *Powershell.ps_args]
            output = execute(command, dir: dir, interpreter: interpreter)
          else
            path, args = *Powershell.process_from_extension(file)
            args += Powershell.escape_arguments(arguments)
            command = args.unshift(path).join(' ')
            output = execute(command, dir: dir)
          end
          Bolt::Result.for_command(target,
                                   output.stdout.string,
                                   output.stderr.string,
                                   output.exit_code,
                                   'script', script)
        end
      end

      def run_task(target, task, arguments, options = {})
        self.class.validate(options)
        implementation = select_implementation(target, task)
        executable = implementation['path']
        input_method = implementation['input_method']
        extra_files = implementation['files']

        in_tmpdir(target.options['tmpdir']) do |dir|
          if extra_files.empty?
            script = File.join(dir, File.basename(executable))
          else
            arguments['_installdir'] = dir
            script_dest = File.join(dir, task.tasks_dir)
            FileUtils.mkdir_p([script_dest] + extra_files.map { |file| File.join(dir, File.dirname(file['name'])) })

            script = File.join(script_dest, File.basename(executable))
            extra_files.each do |file|
              dest = File.join(dir, file['name'])
              copy_file(file['path'], dest)
              File.chmod(0o750, dest)
            end
          end

          copy_file(executable, script)
          File.chmod(0o750, script)

          interpreter = select_interpreter(script, target.options['interpreters'])
          interpreter_debug = interpreter ? " using '#{interpreter}' interpreter" : nil
          # log the arguments with sensitive data redacted, do NOT log unwrapped_arguments
          logger.debug("Running '#{script}' with #{arguments.to_json}#{interpreter_debug}")
          unwrapped_arguments = unwrap_sensitive_args(arguments)

          stdin = STDIN_METHODS.include?(input_method) ? JSON.dump(unwrapped_arguments) : nil
          if ENVIRONMENT_METHODS.include?(input_method)
            environment_params = envify_params(unwrapped_arguments).each_with_object([]) do |(arg, val), list|
              list << Powershell.set_env(arg, val)
            end
            environment_params = environment_params.join("\n") + "\n"
          else
            environment_params = ""
          end

          if Powershell.powershell_file?(script) && stdin.nil?
            command = Powershell.run_ps_task(arguments, script, input_method)
            command = environment_params + Powershell.shell_init + command
            interpreter ||= ['powershell.exe', *Powershell.ps_args]
            output =
              if input_method == 'powershell'
                execute(command, dir: dir, interpreter: interpreter)
              else
                execute(command, dir: dir, stdin: stdin, interpreter: interpreter)
              end
          end
          unless output
            if interpreter
              env = ENVIRONMENT_METHODS.include?(input_method) ? envify_params(unwrapped_arguments) : nil
              output = execute(script, stdin: stdin, env: env, dir: dir, interpreter: interpreter)
            else
              path, args = *Powershell.process_from_extension(script)
              command = args.unshift(path).join(' ')
              command = environment_params + Powershell.shell_init + command
              output = execute(command, dir: dir, stdin: stdin, interpreter: 'powershell.exe')
            end
          end
          Bolt::Result.for_task(target,
                                output.stdout.string,
                                output.stderr.string,
                                output.exit_code,
                                task.name)
        end
      end

      def connected?(_targets)
        true
      end
    end
  end
end
