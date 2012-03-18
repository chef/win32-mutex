# encoding: utf-8
#######################################################################
# test_Win32::Mutex.rb
#
# Test suite for the win32-Win32::Mutex package. This test suite
# should be run via the 'rake test' task.
#######################################################################
require 'rubygems'
gem 'test-unit'

require 'test/unit'
require 'win32/mutex'

class TC_Win32_Mutex < Test::Unit::TestCase
  def setup
    @mutex  = Win32::Mutex.new(true, 'test')
    @umutex = Win32::Mutex.new(false, 'Ηελλας')
  end

  def test_version
    assert_equal('0.3.2', Win32::Mutex::VERSION)
  end

  def test_open
    assert_respond_to(Win32::Mutex, :open)
    assert_nothing_raised{ Win32::Mutex.open('test'){} }
    assert_nothing_raised{ Win32::Mutex.open('Ηελλας'){} }
  end

  def test_open_expected_errors
    assert_raise(Win32::Mutex::Error){ Win32::Mutex.open('bogus'){} }
  end

  def test_release
    assert_respond_to(@mutex, :release)
    assert_nothing_raised{ @mutex.release }
  end

  def test_initial_owner
    assert_respond_to(@mutex, :initial_owner?)
    assert_true(@mutex.initial_owner?)
    assert_false(@umutex.initial_owner?)
  end

  def test_inheritable
    assert_respond_to(@mutex, :inheritable?)
    assert_true(@mutex.inheritable?)
  end

  def test_wait
    assert_respond_to(@mutex, :wait)
  end

  def test_wait_any
    assert_respond_to(@mutex, :wait_any)
  end

  def test_wait_all
    assert_respond_to(@mutex, :wait_all)
  end

  def teardown
    @mutex.close
    @umutex.close
    @mutex = nil
    @umutex = nil
  end
end
