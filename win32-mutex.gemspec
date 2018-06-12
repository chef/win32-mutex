require 'rubygems'

Gem::Specification.new do |spec|
  spec.name       = 'win32-mutex'
  spec.version    = '0.4.3'
  spec.author     = 'Daniel J. Berger'
  spec.license    = 'Artistic 2.0'
  spec.email      = 'djberg96@gmail.com'
  spec.homepage   = 'https://github.com/chef/win32-mutex'
  spec.summary    = 'Interface to MS Windows Mutex objects.'
  spec.test_file  = 'test/test_win32_mutex.rb'
  spec.files      = Dir['**/*'].reject{ |f| f.include?('git') }

  spec.extra_rdoc_files  = ['README.md', 'CHANGES', 'MANIFEST']
  spec.required_ruby_version = '> 1.9.0'

  spec.add_dependency('win32-ipc', '>= 0.6.0')

  spec.add_development_dependency('rake')
  spec.add_development_dependency('test-unit')

  spec.description = <<-EOF
    The win32-mutex library provides an interface for creating mutex objects
    on MS Windows. A mutex object is a synchronization object whose state
    is set to signaled when it is not owned by any thread, and non-signaled
    when it is owned.
  EOF
end
