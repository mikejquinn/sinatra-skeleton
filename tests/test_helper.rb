# Add any helper functions that any type of test may be interested in using. This file should be required
# by the test helper classes for each category of tests (unit/integration/etc)

# The absence of Turn shouldn't prevent tests from running
begin; require "turn/autorun"; rescue LoadError; end

require "test_environment"
require "lib/script_environment"

require "factory_girl"
require "database_cleaner"

FactoryGirl.definition_file_paths = ["#{File.dirname(__FILE__)}/factories.rb"]
FactoryGirl.find_definitions

DatabaseCleaner.strategy = :truncation

class AppTestCase < Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods

  def run(*args, &block)
    setup
    result = super
    teardown

    result
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
