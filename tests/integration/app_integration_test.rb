require_relative "../integration_test_helper"

class AppIntegrationTest < AppIntegrationTestCase
  context "home page" do
    should "return hello world json" do
      get "/hello.json"
      assert_status 200
      assert json_response["hello"].eql?("world")
    end
  end
end
