# win32-mutex

[![Gem Version](https://badge.fury.io/rb/win32-mutex.svg)](https://badge.fury.io/rb/win32-mutex)

Interface for Mutexes on MS Windows.

## Prerequisites

- win32-ipc 0.6.0 or later

## Installation

```
gem install win32-mutex
```

## Synopsis

```ruby
require 'win32/mutex'

# Do not leave out the 'Win32::', otherwise you're using Ruby's Mutex class.
Win32::Mutex.new(false, 'test') do |m|
  # Do stuff
  m.release
end
```

## Documentation

The mutex.rb file contains inline RDoc documentation. If you installed this file as a gem, then you have the docs.

For an example of win32-mutex in action, look at the example_win32_mutex.rb file in the 'examples' directory. You can also run the 'examples' rake task.

## Notes

The Mutex class is a subclass of Win32::Ipc (win32-ipc). This library require's the win32-ipc library internally. You don't need to explicitly call it.

## Acknowledgements

Originally adapted from the Win32::Mutex Perl module.

## Known Bugs

None that I know of. Please log any other bug reports on the project page at <https://github.com/chef/win32-mutex>.

## License

Artistic 2.0

## Copyright

(C) 2003-2013 Daniel J. Berger, All Rights Reserved

## Warranty

This package is provided "as is" and without any express or implied warranties, including, without limitation, the implied warranties of merchantability and fitness for a particular purpose.

## Authors

- Daniel J. Berger
- Park Heesob
