require 'rake'
require 'rake/testtask'
require 'rbconfig'
include Config

desc 'Install the win32-mutex package (non-gem)'
task :install do
   sitelibdir = CONFIG['sitelibdir']
   installdir = File.join(sitelibdir, 'win32')
   file = 'lib\win32\mutex.rb'

   Dir.mkdir(installdir) unless File.exists?(installdir)
   FileUtils.cp(file, installdir, :verbose => true)
end

desc 'Run the example program'
task :example do
   ruby '-Ilib examples/example_win32_mutex.rb'
end

Rake::TestTask.new do |t|
   t.verbose = true
   t.warning = true
end
