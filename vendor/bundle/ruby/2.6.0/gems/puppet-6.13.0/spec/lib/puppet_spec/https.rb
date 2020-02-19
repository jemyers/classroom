require 'spec_helper'
require 'webrick'

class PuppetSpec::HTTPSServer
  include PuppetSpec::Fixtures

  attr_reader :ca_cert, :ca_crl, :server_cert, :server_key

  def initialize
    @ca_cert = cert_fixture('ca.pem')
    @ca_crl = crl_fixture('crl.pem')
    @server_key = key_fixture('127.0.0.1-key.pem')
    @server_cert = cert_fixture('127.0.0.1.pem')
    @config = WEBrick::Config::HTTP.dup
  end

  def handle_request(ctx, ssl, response_proc)
    req = WEBrick::HTTPRequest.new(@config)
    req.parse(ssl)

    res = WEBrick::HTTPResponse.new(@config)
    res.status = 200
    res.body = 'OK'
    response_proc.call(res) if response_proc

    res.send_response(ssl)
  end

  def start_server(ctx_proc: nil, response_proc: nil, &block)
    errors = []

    IO.pipe {|stop_pipe_r, stop_pipe_w|
      store = OpenSSL::X509::Store.new
      store.add_cert(@ca_cert)
      store.purpose = OpenSSL::X509::PURPOSE_SSL_CLIENT
      ctx = OpenSSL::SSL::SSLContext.new
      ctx.cert_store = store
      ctx.cert = @server_cert
      ctx.key = @server_key
      ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
      ctx_proc.call(ctx) if ctx_proc

      Socket.do_not_reverse_lookup = true
      tcps = TCPServer.new("127.0.0.1", 0)
      begin
        port = tcps.connect_address.ip_port
        begin
          server_thread = Thread.new do
            begin
              ssls = OpenSSL::SSL::SSLServer.new(tcps, ctx)
              ssls.start_immediately = true

              loop do
                readable, = IO.select([ssls, stop_pipe_r])
                break if readable.include? stop_pipe_r

                ssl = ssls.accept
                begin
                  handle_request(ctx, ssl, response_proc)
                ensure
                  ssl.close
                end
              end
            rescue => e
              # uncomment this line if something goes wrong
              # puts "SERVER #{e.message}"
              errors << e
            end
          end

          begin
            yield port
          ensure
            stop_pipe_w.close
          end
        ensure
          server_thread.join
        end
      ensure
        tcps.close
      end
    }

    errors
  end
end
