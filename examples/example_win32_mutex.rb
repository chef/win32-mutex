##############################################################
# example_win32_mutex.rb
#
# A test script for general futzing.  Modify as you see fit.
# This test script requires win32-process and win32-mmap.
##############################################################
MUTEXNAME = "This is a very long name".freeze

require "win32/mutex"
require "win32/process"
require "win32/mmap"
include Win32

pid = Process.fork

# child_1
if pid.nil?
  mm = MMap.open("test")
  mx = Win32::Mutex.open(MUTEXNAME)
  5.times {
    mx.wait
    puts "child_1 wait "
    mm.gvalue += 123
    sleep 1
    mm.gvalue -= 123
    mx.release
    puts "child_1 release "
  }
  exit 1
end

pid2 = Process.fork

# child_2
if pid2.nil?
  mm = MMap.open("test")
  mx = Win32::Mutex.open(MUTEXNAME)
  4.times {
    mx.wait
    puts "child_2 wait "
    mm.gvalue += 456
    sleep 2
    mm.gvalue -= 456
    mx.release
    puts "child_2 release "
  }
  exit 1
end

# parent
mm = MMap.new(size: 1024, name: "test", inherit: true)
mm.gvalue = 5
mx = Win32::Mutex.new(false, MUTEXNAME)

3.times {
  mx.wait
  puts "parent wait"
  sleep 5
  printf("Value of GValue=%d\n", mm.gvalue)
  mx.release
  puts "parent release"
}

p Process.waitpid2(pid)
p Process.waitpid2(pid2)