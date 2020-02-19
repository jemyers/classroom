require 'spec_helper'
require 'webmock/rspec'
require 'puppet/http'

describe Puppet::HTTP::Client do
  let(:uri) { URI.parse('https://www.example.com') }
  let(:client) { described_class.new }
  let(:credentials) { ['user', 'pass'] }

  it 'creates unique sessions' do
    expect(client.create_session).to_not eq(client.create_session)
  end

  context "when connecting" do
    it 'connects to HTTP URLs' do
      uri = URI.parse('http://www.example.com')

      client.connect(uri) do |http|
        expect(http.address).to eq('www.example.com')
        expect(http.port).to eq(80)
        expect(http).to_not be_use_ssl
      end
    end

    it 'connects to HTTPS URLs' do
      client.connect(uri) do |http|
        expect(http.address).to eq('www.example.com')
        expect(http.port).to eq(443)
        expect(http).to be_use_ssl
      end
    end

    it 'raises ConnectionError if the connection is refused' do
      allow_any_instance_of(Net::HTTP).to receive(:start).and_raise(Errno::ECONNREFUSED)

      expect {
        client.connect(uri)
      }.to raise_error(Puppet::HTTP::ConnectionError, %r{^Request to https://www.example.com failed after .* seconds: (Connection refused|No connection could be made because the target machine actively refused it)})
    end

    it 'raises ConnectionError if the connect times out' do
      allow_any_instance_of(Net::HTTP).to receive(:start).and_raise(Net::OpenTimeout)

      expect {
        client.connect(uri)
      }.to raise_error(Puppet::HTTP::ConnectionError, %r{^Request to https://www.example.com timed out connect operation after .* seconds})
    end
  end

  context 'after connecting' do
    def expect_http_error(cause, expected_message)
      expect {
        client.connect(uri) do |_|
          raise cause, 'whoops'
        end
      }.to raise_error(Puppet::HTTP::HTTPError, expected_message)
    end

    it 're-raises HTTPError' do
      expect_http_error(Puppet::HTTP::HTTPError, 'whoops')
    end

    it 'raises HTTPError if connection is interrupted while reading' do
      expect_http_error(EOFError, %r{^Request to https://www.example.com interrupted after .* seconds})
    end

    it 'raises HTTPError if connection times out' do
      expect_http_error(Net::ReadTimeout, %r{^Request to https://www.example.com timed out read operation after .* seconds})
    end

    it 'raises HTTPError if connection fails' do
      expect_http_error(ArgumentError, %r{^Request to https://www.example.com failed after .* seconds})
    end
  end

  context "when closing" do
    it "closes all connections in the pool" do
      pool = double('pool')
      expect(pool).to receive(:close)

      client = described_class.new(pool: pool)
      client.close
    end
  end

  context "for GET requests" do
    it "includes default HTTP headers" do
      stub_request(:get, uri).with do |request|
        expect(request.headers).to include({'X-Puppet-Version' => /./, 'User-Agent' => /./})
        expect(request.headers).to_not include('X-Puppet-Profiling')
      end

      client.get(uri)
    end

    it "stringifies keys and encodes values in the query" do
      stub_request(:get, uri).with(query: "foo=bar%3Dbaz")

      client.get(uri, params: {:foo => "bar=baz"})
    end

    it "fails if a user passes in an invalid param type" do
      environment = Puppet::Node::Environment.create(:testing, [])

      expect{client.get(uri, params: {environment: environment})}.to raise_error(Puppet::HTTP::SerializationError, /HTTP REST queries cannot handle values of type/)
    end

    it "merges custom headers with default ones" do
      stub_request(:get, uri).with(headers: { 'X-Foo' => 'Bar', 'X-Puppet-Version' => /./, 'User-Agent' => /./ })

      client.get(uri, headers: {'X-Foo' => 'Bar'})
    end

    it "returns the response" do
      stub_request(:get, uri)

      response = client.get(uri)
      expect(response).to be_an_instance_of(Puppet::HTTP::Response)
      expect(response).to be_success
      expect(response.code).to eq(200)
    end

    it "returns the entire response body" do
      stub_request(:get, uri).to_return(body: "abc")

      expect(client.get(uri).body).to eq("abc")
    end

    it "streams the response body when a block is given" do
      stub_request(:get, uri).to_return(body: "abc")

      io = StringIO.new
      client.get(uri) do |response|
        response.read_body do |data|
          io.write(data)
        end
      end

      expect(io.string).to eq("abc")
    end
  end

  context "for HEAD requests" do
    it "includes default HTTP headers" do
      stub_request(:head, uri).with(headers: {'X-Puppet-Version' => /./, 'User-Agent' => /./})

      client.head(uri)
    end

    it "stringifies keys and encodes values in the query" do
      stub_request(:head, uri).with(query: "foo=bar%3Dbaz")

      client.head(uri, params: {:foo => "bar=baz"})
    end

    it "merges custom headers with default ones" do
      stub_request(:head, uri).with(headers: { 'X-Foo' => 'Bar', 'X-Puppet-Version' => /./, 'User-Agent' => /./ })

      client.head(uri, headers: {'X-Foo' => 'Bar'})
    end

    it "returns the response" do
      stub_request(:head, uri)

      response = client.head(uri)
      expect(response).to be_an_instance_of(Puppet::HTTP::Response)
      expect(response).to be_success
      expect(response.code).to eq(200)
    end

    it "returns the entire response body" do
      stub_request(:head, uri).to_return(body: "abc")

      expect(client.head(uri).body).to eq("abc")
    end
  end

  context "for PUT requests" do
    it "includes default HTTP headers" do
      stub_request(:put, uri).with do |request|
        expect(request.headers).to include({'X-Puppet-Version' => /./, 'User-Agent' => /./})
        expect(request.headers).to_not include('X-Puppet-Profiling')
      end

      client.put(uri, content_type: 'text/plain', body: "")
    end

    it "stringifies keys and encodes values in the query" do
      stub_request(:put, "https://www.example.com").with(query: "foo=bar%3Dbaz")

      client.put(uri, params: {:foo => "bar=baz"}, content_type: 'text/plain', body: "")
    end

    it "includes custom headers" do
      stub_request(:put, "https://www.example.com").with(headers: { 'X-Foo' => 'Bar' })

      client.put(uri, headers: {'X-Foo' => 'Bar'}, content_type: 'text/plain', body: "")
    end

    it "returns the response" do
      stub_request(:put, uri)

      response = client.put(uri, content_type: 'text/plain', body: "")
      expect(response).to be_an_instance_of(Puppet::HTTP::Response)
      expect(response).to be_success
      expect(response.code).to eq(200)
    end

    it "sets content-length and content-type for the body" do
      stub_request(:put, uri).with(headers: {"Content-Length" => "5", "Content-Type" => "text/plain"})

      client.put(uri, content_type: 'text/plain', body: "hello")
    end
  end

  context "for POST requests" do
    it "includes default HTTP headers" do
      stub_request(:post, uri).with(headers: {'X-Puppet-Version' => /./, 'User-Agent' => /./})

      client.post(uri, content_type: 'text/plain', body: "")
    end

    it "stringifies keys and encodes values in the query" do
      stub_request(:post, "https://www.example.com").with(query: "foo=bar%3Dbaz")

      client.post(uri, params: {:foo => "bar=baz"}, content_type: 'text/plain', body: "")
    end

    it "includes custom headers" do
      stub_request(:post, "https://www.example.com").with(headers: { 'X-Foo' => 'Bar' })

      client.post(uri, headers: {'X-Foo' => 'Bar'}, content_type: 'text/plain', body: "")
    end

    it "returns the response" do
      stub_request(:post, uri)

      response = client.post(uri, content_type: 'text/plain', body: "")
      expect(response).to be_an_instance_of(Puppet::HTTP::Response)
      expect(response).to be_success
      expect(response.code).to eq(200)
    end

    it "sets content-length and content-type for the body" do
      stub_request(:post, uri).with(headers: {"Content-Length" => "5", "Content-Type" => "text/plain"})

      client.post(uri, content_type: 'text/plain', body: "hello")
    end

    it "streams the response body when a block is given" do
      stub_request(:post, uri).to_return(body: "abc")

      io = StringIO.new
      client.post(uri, content_type: 'text/plain', body: "") do |response|
        response.read_body do |data|
          io.write(data)
        end
      end

      expect(io.string).to eq("abc")
    end
  end

  context "for DELETE requests" do
    it "includes default HTTP headers" do
      stub_request(:delete, uri).with(headers: {'X-Puppet-Version' => /./, 'User-Agent' => /./})

      client.delete(uri)
    end

    it "merges custom headers with default ones" do
      stub_request(:delete, uri).with(headers: { 'X-Foo' => 'Bar', 'X-Puppet-Version' => /./, 'User-Agent' => /./ })

      client.delete(uri, headers: {'X-Foo' => 'Bar'})
    end

    it "stringifies keys and encodes values in the query" do
      stub_request(:delete, "https://www.example.com").with(query: "foo=bar%3Dbaz")

      client.delete(uri, params: {:foo => "bar=baz"})
    end

    it "returns the response" do
      stub_request(:delete, uri)

      response = client.delete(uri)
      expect(response).to be_an_instance_of(Puppet::HTTP::Response)
      expect(response).to be_success
      expect(response.code).to eq(200)
    end

    it "returns the entire response body" do
      stub_request(:delete, uri).to_return(body: "abc")

      expect(client.delete(uri).body).to eq("abc")
    end
  end

  context "Basic Auth" do
    it "submits credentials for GET requests" do
      stub_request(:get, uri).with(basic_auth: credentials)

      client.get(uri, user: 'user', password: 'pass')
    end

    it "submits credentials for PUT requests" do
      stub_request(:put, uri).with(basic_auth: credentials)

      client.put(uri, content_type: 'text/plain', body: "hello", user: 'user', password: 'pass')
    end

    it "returns response containing access denied" do
      stub_request(:get, uri).with(basic_auth: credentials).to_return(status: [403, "Ye Shall Not Pass"])

      response = client.get(uri, user: 'user', password: 'pass')
      expect(response.code).to eq(403)
      expect(response.reason).to eq("Ye Shall Not Pass")
      expect(response).to_not be_success
    end

    it 'omits basic auth if user is nil' do
      stub_request(:get, uri).with do |req|
        expect(req.headers).to_not include('Authorization')
      end

      client.get(uri, user: nil, password: 'pass')
    end

    it 'omits basic auth if password is nil' do
      stub_request(:get, uri).with do |req|
        expect(req.headers).to_not include('Authorization')
      end

      client.get(uri, user: 'user', password: nil)
    end
  end

  context "when redirecting" do
    let(:start_url)  { URI("https://www.example.com:8140/foo") }
    let(:bar_url)  { "https://www.example.com:8140/bar" }
    let(:baz_url) { "https://www.example.com:8140/baz" }
    let(:other_host)  { "https://other.example.com:8140/qux" }

    def redirect_to(status: 302, url:)
      { status: status, headers: { 'Location' => url }, body: "Redirected to #{url}" }
    end

    it "preserves GET method" do
      stub_request(:get, start_url).to_return(redirect_to(url: bar_url))
      stub_request(:get, bar_url).to_return(status: 200)

      response = client.get(start_url)
      expect(response).to be_success
    end

    it "preserves PUT method" do
      stub_request(:put, start_url).to_return(redirect_to(url: bar_url))
      stub_request(:put, bar_url).to_return(status: 200)

      response = client.put(start_url, body: "", content_type: 'text/plain')
      expect(response).to be_success
    end

    it "preserves query parameters" do
      query = { 'debug' => true }
      stub_request(:get, start_url).with(query: query).to_return(redirect_to(url: bar_url))
      stub_request(:get, bar_url).with(query: query).to_return(status: 200)

      response = client.get(start_url, params: query)
      expect(response).to be_success
    end

    it "preserves custom and default headers when redirecting" do
      headers = { 'X-Foo' => 'Bar', 'X-Puppet-Version' => Puppet.version }
      stub_request(:get, start_url).with(headers: headers).to_return(redirect_to(url: bar_url))
      stub_request(:get, bar_url).with(headers: headers).to_return(status: 200)

      response = client.get(start_url, headers: headers)
      expect(response).to be_success
    end

    it "preserves basic authorization" do
      stub_request(:get, start_url).with(basic_auth: credentials).to_return(redirect_to(url: bar_url))
      stub_request(:get, bar_url).with(basic_auth: credentials).to_return(status: 200)

      client.get(start_url, user: 'user', password: 'pass')
    end

    it "redirects given a relative location" do
      relative_url = "/people.html"
      stub_request(:get, start_url).to_return(redirect_to(url: relative_url))
      stub_request(:get, "https://www.example.com:8140/people.html").to_return(status: 200)

      response = client.get(start_url)
      expect(response).to be_success
    end

    it "preserves query parameters given a relative location" do
      relative_url = "/people.html"
      query = { 'debug' => true }
      stub_request(:get, start_url).with(query: query).to_return(redirect_to(url: relative_url))
      stub_request(:get, "https://www.example.com:8140/people.html").with(query: query).to_return(status: 200)

      response = client.get(start_url, params: query)
      expect(response).to be_success
    end

    it "preserves request body for each request" do
      data = 'some data'
      stub_request(:put, start_url).with(body: data).to_return(redirect_to(url: bar_url))
      stub_request(:put, bar_url).with(body: data).to_return(status: 200)

      response = client.put(start_url, body: data, content_type: 'text/plain')
      expect(response).to be_success
    end

    it "returns the body from the final response" do
      stub_request(:get, start_url).to_return(redirect_to(url: bar_url))
      stub_request(:get, bar_url).to_return(status: 200, body: 'followed')

      response = client.get(start_url)
      expect(response.body).to eq('followed')
    end

    [301, 307].each do |code|
      it "also redirects on #{code}" do
        stub_request(:get, start_url).to_return(redirect_to(status: code, url: bar_url))
        stub_request(:get, bar_url).to_return(status: 200)

        response = client.get(start_url)
        expect(response).to be_success
      end
    end

    [303, 308].each do |code|
      it "returns an error on #{code}" do
        stub_request(:get, start_url).to_return(redirect_to(status: code, url: bar_url))

        response = client.get(start_url)
        expect(response.code).to eq(code)
        expect(response).to_not be_success
      end
    end

    it "raises an error if the Location header is missing" do
      stub_request(:get, start_url).to_return(status: 302)

      expect {
        client.get(start_url)
      }.to raise_error(Puppet::HTTP::ProtocolError, "Location response header is missing")
    end

    it "raises an error if the Location header is invalid" do
      stub_request(:get, start_url).to_return(redirect_to(status: 302, url: 'http://foo"bar'))

      expect {
        client.get(start_url)
      }.to raise_error(Puppet::HTTP::ProtocolError, /Location URI is invalid/)
    end

    it "raises an error if limit is 0 and we're asked to follow" do
      stub_request(:get, start_url).to_return(redirect_to(url: bar_url))

      client = described_class.new(redirect_limit: 0)
      expect {
        client.get(start_url)
      }.to raise_error(Puppet::HTTP::TooManyRedirects, %r{Too many HTTP redirections for https://www.example.com:8140})
    end

    it "raises an error if asked to follow redirects more times than the limit" do
      stub_request(:get, start_url).to_return(redirect_to(url: bar_url))
      stub_request(:get, bar_url).to_return(redirect_to(url: baz_url))

      client = described_class.new(redirect_limit: 1)
      expect {
        client.get(start_url)
      }.to raise_error(Puppet::HTTP::TooManyRedirects, %r{Too many HTTP redirections for https://www.example.com:8140})
    end

    it "follows multiple redirects if equal to or less than the redirect limit" do
      stub_request(:get, start_url).to_return(redirect_to(url: bar_url))
      stub_request(:get, bar_url).to_return(redirect_to(url: baz_url))
      stub_request(:get, baz_url).to_return(status: 200)

      client = described_class.new(redirect_limit: 2)
      response = client.get(start_url)
      expect(response).to be_success
    end

    it "redirects to a different host" do
      stub_request(:get, start_url).to_return(redirect_to(url: other_host))
      stub_request(:get, other_host).to_return(status: 200)

      response = client.get(start_url)
      expect(response).to be_success
    end

    it "redirects from http to https" do
      http = URI("http://example.com/foo")
      https = URI("https://example.com/bar")

      stub_request(:get, http).to_return(redirect_to(url: https))
      stub_request(:get, https).to_return(status: 200)

      response = client.get(http)
      expect(response).to be_success
    end

    it "redirects from https to http" do
      http = URI("http://example.com/foo")
      https = URI("https://example.com/bar")

      stub_request(:get, https).to_return(redirect_to(url: http))
      stub_request(:get, http).to_return(status: 200)

      response = client.get(https)
      expect(response).to be_success
    end
  end

  context "when response indicates an overloaded server" do
    def retry_after(datetime)
      stub_request(:get, uri)
        .to_return(status: [503, 'Service Unavailable'], headers: {'Retry-After' => datetime}).then
        .to_return(status: 200)
    end

    it "returns a 503 response if Retry-After is not set" do
      stub_request(:get, uri).to_return(status: [503, 'Service Unavailable'])

      expect(client.get(uri).code).to eq(503)
    end

    it "raises if Retry-After is not convertible to an Integer or RFC 2822 Date" do
      stub_request(:get, uri).to_return(status: [503, 'Service Unavailable'], headers: {'Retry-After' => 'foo'})

      expect {
        client.get(uri)
      }.to raise_error(Puppet::HTTP::ProtocolError, /Failed to parse Retry-After header 'foo' as an integer or RFC 2822 date/)
    end

    it "should sleep and retry if Retry-After is an Integer" do
      retry_after('42')

      expect(::Kernel).to receive(:sleep).with(42)

      client.get(uri)
    end

    it "should sleep and retry if Retry-After is an RFC 2822 Date" do
      retry_after('Wed, 13 Apr 2005 15:18:05 GMT')

      now = DateTime.new(2005, 4, 13, 8, 17, 5, '-07:00')
      allow(DateTime).to receive(:now).and_return(now)

      expect(::Kernel).to receive(:sleep).with(60)

      client.get(uri)
    end

    it "should sleep for no more than the Puppet runinterval" do
      retry_after('60')
      Puppet[:runinterval] = 30

      expect(::Kernel).to receive(:sleep).with(30)

      client.get(uri)
    end

    it "should sleep for 0 seconds if the RFC 2822 date has past" do
      retry_after('Wed, 13 Apr 2005 15:18:05 GMT')

      expect(::Kernel).to receive(:sleep).with(0)

      client.get(uri)
    end
  end
end
