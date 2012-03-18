require 'rake'
require 'rake/testtask'
require 'rake/clean'

CLEAN.include("**/*.gem")

namespace :gem do
  desc 'Create the win32-mutex gem'
  task :create => [:clean] do
    spec = eval(IO.read('win32-mutex.gemspec'))
    Gem::Builder.new(spec).build
  end

  desc 'Install the win32-mutex gem'
  task :install => [:create] do
    file = Dir["*.gem"].first
    sh "gem install #{file}"
  end
end

desc 'Run the example program'
task :example do
  ruby '-Ilib examples/example_win32_mutex.rb'
end

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = true
end

task :default => :test
