require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

desc "Run all tests by default"
task :default => :test

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end
