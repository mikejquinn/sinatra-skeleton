ENV['RACK_ENV']="test"
require "bundler/setup"
require "pathological"
require "shoulda-context"
require "mocha/setup"
require "json"

require "tests/test_helper" # must be loaded prior to rack/test
