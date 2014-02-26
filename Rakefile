require "bundler/setup"
require "pathological"
require "rake/testtask"
require "environment"

Dir[File.join(File.expand_path(File.dirname(__FILE__)), "tasks/**", "*.rake")].sort.each do |lib|
  Rake.application.add_import(lib)
end
