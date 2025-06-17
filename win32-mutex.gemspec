lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "win32-mutex"
  spec.version       = "0.4.5" # Fix: Hardcode version instead of using undefined constant
  spec.authors       = ["Daniel J. Berger"]
  spec.email         = ["djberg96@gmail.com"]
  spec.summary       = "Win32 Mutex implementation"
  spec.description   = "A Ruby library providing mutex functionality for Windows"
  spec.homepage      = "https://github.com/chef/win32-mutex"
  spec.license       = "Artistic 2.0"

  spec.files         = Dir.glob("{bin,lib}/**/*") + %w{README.md CHANGES MANIFEST}
  spec.require_paths = ["lib"]

  spec.required_ruby_version = "~> 3.1"

  spec.add_dependency("win32-ipc", ">= 0.6.0")

  spec.add_development_dependency("rake")
  spec.add_development_dependency("test-unit")

  spec.description = <<-EOF
    The win32-mutex library provides an interface for creating mutex objects
    on MS Windows. A mutex object is a synchronization object whose state
    is set to signaled when it is not owned by any thread, and non-signaled
    when it is owned.
  EOF
end
