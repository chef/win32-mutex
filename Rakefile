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

desc "Check Linting and code style."
task :style do
  require "rubocop/rake_task"
  require "cookstyle/chefstyle"

  if RbConfig::CONFIG["host_os"] =~ /mswin|mingw|cygwin/
    # Windows-specific command, rubocop erroneously reports the CRLF in each file which is removed when your PR is uploaeded to GitHub.
    # This is a workaround to ignore the CRLF from the files before running cookstyle.
    sh "cookstyle --chefstyle -c .rubocop.yml --except Layout/EndOfLine"
  else
    sh "cookstyle --chefstyle -c .rubocop.yml"
  end
rescue LoadError
  puts "Rubocop or Cookstyle gems are not installed. bundle install first to make sure all dependencies are installed."
end
