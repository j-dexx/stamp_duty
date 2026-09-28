require "bundler/gem_tasks"
require "rake/testtask"
require "standard/rake"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

desc "Validate RBS signatures"
task :rbs do
  sh "rbs", "-r", "bigdecimal", "-r", "forwardable", "-I", "sig", "validate"
end

task default: %i[test standard rbs]
