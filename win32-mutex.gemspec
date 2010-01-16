require 'rubygems'

spec = Gem::Specification.new do |gem|
   gem.name      = 'win32-mutex'
   gem.version   = '0.3.1'
   gem.author    = 'Daniel J. Berger'
   gem.license   = 'Artistic 2.0'
   gem.email     = 'djberg96@gmail.com'
   gem.homepage  = 'http://www.rubyforge.org/projects/win32utils'
   gem.platform  = Gem::Platform::RUBY
   gem.summary   = 'Interface to MS Windows Mutex objects.'
   gem.test_file = 'test/test_win32_mutex.rb'
   gem.has_rdoc  = true
   gem.files     = Dir['**/*'].reject{ |f| f.include?('CVS') }

   gem.rubyforge_project = 'win32utils'
   gem.extra_rdoc_files  = ['README', 'CHANGES', 'MANIFEST']

   gem.add_dependency('win32-ipc', '>= 0.5.0')
   
   gem.add_development_dependency('test-unit', '>= 2.0.3')
   gem.add_development_dependency('win32-process', '>= 0.6.1')
   gem.add_development_dependency('win32-mmap', '>= 0.2.2')

   gem.description = <<-EOF
      The win32-mutex library provides an interface for creating mutex objects
      on MS Windows. A mutex object is a synchronization object whose state
      is set to signaled when it is not owned by any thread, and non-signaled
      when it is owned.
   EOF
end

Gem::Builder.new(spec).build
