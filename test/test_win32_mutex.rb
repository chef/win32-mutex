# encoding: utf-8
#######################################################################
# test_win32_mutex.rb
#
# Test suite for the win32-mutex library. This test suite should be
# run via the 'rake test' task.
#######################################################################
require 'test-unit'
require 'win32/mutex'

class TC_Win32_Mutex < Test::Unit::TestCase
  def setup
    @mutex  = Win32::Mutex.new(true, 'test')
    @umutex = Win32::Mutex.new(false, 'Ηελλας')
  end

  def test_version
    assert_equal('0.4.0', Win32::Mutex::VERSION)
  end

  test "constructor with no arguments works as expected" do
    mutex = nil
    assert_nothing_raised{ mutex = Win32::Mutex.new }
    mutex.close
  end

  test "default attributes are set to expected values" do
    mutex = Win32::Mutex.new
    assert_false(mutex.initial_owner?)
    assert_true(mutex.inheritable?)
    assert_nil(mutex.name)
    mutex.close
  end

  test "open method works as expected" do
    assert_respond_to(Win32::Mutex, :open)
    assert_nothing_raised{ Win32::Mutex.open('test'){} }
    assert_nothing_raised{ Win32::Mutex.open('Ηελλας'){} }
  end

  test "attempting to open an unknown mutex raises an error" do
    assert_raise(Errno::ENOENT){ Win32::Mutex.open('bogus'){} }
  end

  test "release method works as expected" do
    assert_respond_to(@mutex, :release)
    assert_nothing_raised{ @mutex.release }
  end

  test "initial_owner? works as expected and returns expected value" do
    assert_respond_to(@mutex, :initial_owner?)
    assert_true(@mutex.initial_owner?)
    assert_false(@umutex.initial_owner?)
  end

  test "inheritable? works as expected and returns expected value" do
    assert_respond_to(@mutex, :inheritable?)
    assert_true(@mutex.inheritable?)
  end

  test "wait method was inherited" do
    assert_respond_to(@mutex, :wait)
  end

  test "wait_any method was inherited" do
    assert_respond_to(@mutex, :wait_any)
  end

  test "wait_all method was inherited" do
    assert_respond_to(@mutex, :wait_all)
  end

  test "ffi functions are private" do
    assert_not_respond_to(Win32::Mutex, :CreateMutexW)
    assert_not_respond_to(Win32::Mutex, :OpenMutexW)
    assert_not_respond_to(Win32::Mutex, :ReleaseMutex)
  end

  def teardown
    @mutex.close
    @umutex.close
    @mutex = nil
    @umutex = nil
  end
end
