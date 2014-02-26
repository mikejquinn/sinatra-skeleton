ENV['RACK_ENV']="test"
require "bundler/setup"
require "pathological"
require "shoulda-context"
require "mocha/setup"
require "json"

require "tests/test_helper" # must be loaded prior to rack/test
require "rack/test"

require "app"

APP=Rack::Builder.parse_file( "#{File.dirname( __FILE__ )}/../config.ru" ).first

class AppIntegrationTestCase < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    APP
  end

  [:post, :put, :patch].each do |method|
    class_eval <<-END
      def #{method}_json( uri, json, env = {}, &block )
        env["CONTENT_TYPE"] = "application/json"
        json = json.to_json if json.is_a?(Hash)
        env[:input] = json
        #{method} uri, {}, env, &block
      end
    END
  end

  def json_response
    @json_response ||= JSON.parse(last_response.body)
  end

  def html_response
    @html_response ||= Nokogiri::HTML(last_response.body)
  end

  def assert_status(status)
    assert_equal status, last_response.status
  end

  # Put data into the encrypted session prior to making the request
  def setup_session(data={})
    sid = SecureRandom.hex(32)
    hsh = data.merge("session_id" => sid)
    data = [Marshal.dump(hsh)].pack('m')
    secret = app.sessions[:secret]
    hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, secret, data)
    str = "#{data}--#{hmac}"
    set_cookie("rack.session=#{URI.encode_www_form_component(str)}")
  end
end
