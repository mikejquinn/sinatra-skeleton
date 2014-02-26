namespace :test do
  Rake::TestTask.new(:units) do |task|
    task.libs << "tests"
    task.test_files = FileList["tests/unit/*test.rb"]
  end

  Rake::TestTask.new(:integrations) do |task|
    task.libs << "tests"
    task.test_files = FileList["tests/integration/*test.rb"]
  end
end

desc "Run all tests"
task :test => ["test:integrations", "test:units"]
