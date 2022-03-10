# win32-mutex Changelog

<!-- latest_release -->
<!-- latest_release -->

<!-- release_rollup -->
<!-- release_rollup -->

<!-- latest_stable_release -->
<!-- latest_stable_release -->

## Previous Release

== 0.4.3 - 17-Nov-2015
* This gem is now signed.
* Added a win32-mutex.rb file for convenience.
* All gem related tasks in the Rakefile now assume Rubygems 2.x.
* The gemspec no longer sets rubyforge_project.
* Added an appveyor.yml file for the MS continuous integration service.

== 0.4.2 - 21-Oct-2013
* Fixed INVALID_HANDLE_VALUE constant for 64-bit Ruby.
* Added Rake as a development dependency.
* Updated gem:create task for Rubygems 2.

== 0.4.1 - 10-Apr-2013
* Fixed HANDLE type in underlying FFI code. This affects 64 bit versions
  of Ruby.

== 0.4.0 - 10-Jul-2012
* Converted to FFI.
* Now requires Ruby 1.9 or later.
* Removed the Error class. If a Windows function fails it raises the
  appropriate SystemCallError (Errno::).

== 0.3.2 - 18-Mar-2011
* Updates to the Rakefile and gemspec.
* One test file change for Ruby 1.9.

== 0.3.1 - 8-Aug-2009
* Changed license to Artistic 2.0.
* Updated the gemspec, including addition of license and description update.
* Renamed the test and example files.
* Added test-unit, win32-process and win32-mmap as development dependencies.

== 0.3.0 - 4-May-2007
* Now pure Ruby.
* Both the Mutex.new and Mutex.open methods now accept a block, and
  automatically close the associated handle at the end of the block.
* The Mutex.new method now accepts an optional third argument that controls
  whether the mutex object can be inherited by other processes.
* Added a gemspec.
* Added a Rakefile, including tasks for installation and testing.
* Removed the doc/mutext.txt file. The documentation is now inlined via RDoc.
  There is also some documentation in the README file.
* The mutex_test.rb script was updated and bugs were fixed.
* Now requires the windows-pr package.

== 0.2.2 - 29-May-2005
* Now Unicode friendly.
* Removed the mutex.rd file.  The mutex.txt file is now rdoc friendly.
* Added some tests and tweaked the test setup.

== 0.2.1 - 1-Mar-2005
* Moved the 'examples' directory to the toplevel directory.
* Made the CHANGES and README files rdoc friendly.

== 0.2.0 - 18-Jul-2004
* Updated to use the newer allocation framework.  This means that, as of this
  release, this package requires Ruby 1.8.0 or later.
* Fixed a minor bug in the initialization function where an expected error
  might not be raised.
* Added tests and documentation for Mutex.open().  This was in the last
  version, but I forgot to document or test it.
* Moved the test.rb script to doc/examples

== 0.1.0 - 3-May-2004
* Initial release
