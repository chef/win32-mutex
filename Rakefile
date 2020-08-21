require "rubygems"
require "rake"
require "rake/testtask"
require "rake/clean"

CLEAN.include("**/*.gem")

desc "Run the example program"
task :example do
  ruby "-Ilib examples/example_win32_mutex.rb"
end

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = true
end

task default: :test
