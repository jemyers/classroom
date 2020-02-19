# frozen_string_literal: true

require 'bolt/util'

# Wait until all targets accept connections.
#
# **NOTE:** Not available in apply block
Puppet::Functions.create_function(:wait_until_available) do
  # Wait until targets are available.
  # @param targets A pattern identifying zero or more targets. See {get_targets} for accepted patterns.
  # @param options Additional options: 'description', 'wait_time', 'retry_interval', '_catch_errors'.
  # @return A list of results, one entry per target. Successful results have no value.
  # @example Wait for targets
  #   wait_until_available($targets, wait_time => 300)
  dispatch :wait_until_available do
    param 'Boltlib::TargetSpec', :targets
    optional_param 'Hash[String[1], Any]', :options
    return_type 'ResultSet'
  end

  def wait_until_available(targets, options = nil)
    unless Puppet[:tasks]
      raise Puppet::ParseErrorWithIssue
        .from_issue_and_stack(Bolt::PAL::Issues::PLAN_OPERATION_NOT_SUPPORTED_WHEN_COMPILING,
                              action: 'wait_until_available')
    end

    options ||= {}
    executor = Puppet.lookup(:bolt_executor)
    inventory = Puppet.lookup(:bolt_inventory)

    executor.report_function_call(self.class.name)

    # Ensure that given targets are all Target instances
    targets = inventory.get_targets(targets)

    if targets.empty?
      call_function('debug', "Simulating wait_until_available - no targets given")
      r = Bolt::ResultSet.new([])
    else
      opts = Bolt::Util.symbolize_top_level_keys(options.reject { |k| k == '_catch_errors' })
      r = executor.wait_until_available(targets, **opts)
    end

    if !r.ok && !options['_catch_errors']
      raise Bolt::RunFailure.new(r, 'wait_until_available')
    end
    r
  end
end
