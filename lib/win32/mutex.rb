require 'win32/ipc'

# The Win32 module serves as a namespace only.
module Win32

  # The Mutex class encapsulates Windows mutex objects.
  class Mutex < Ipc
    typedef :ulong, :dword
    typedef :uintptr_t, :handle

    ffi_lib :kernel32

    private

    class SecurityAttributes < FFI::Struct
      layout(
        :nLength, :dword,
        :lpSecurityDescriptor, :pointer,
        :bInheritHandle, :bool
      )
    end

    attach_function :CreateMutexW, [:pointer, :bool, :buffer_in], :handle
    attach_function :OpenMutexW, [:dword, :bool, :buffer_in], :handle
    attach_function :ReleaseMutex, [:handle], :bool

    private_class_method :CreateMutexW, :OpenMutexW, :ReleaseMutex

    INVALID_HANDLE_VALUE = FFI::Pointer.new(-1).address
    MUTEX_ALL_ACCESS     = 0x1F0001

    public

    # The version of the win32-mutex library
    VERSION = '0.4.3'

    # The name of the mutex object.
    attr_reader :name

    # Creates and returns new Mutex object. If +name+ is omitted, the
    # Mutex object is created without a name, i.e. it's anonymous.
    #
    # If the +initial_owner+ value is true and the caller created the mutex,
    # the calling thread obtains initial ownership of the mutex object.
    # Otherwise, the calling thread does not obtain ownership of the mutex.
    # This value is false by default.
    #
    # If +name+ is provided and it already exists, then it is opened
    # instead, and the +initial_count+ and +max_count+ parameters are
    # ignored.
    #
    # The +inherit+ attribute determines whether or not the mutex can
    # be inherited by child processes.
    #
    def initialize(initial_owner=false, name=nil, inherit=true)
      @initial_owner = initial_owner
      @name          = name
      @inherit       = inherit

      if inherit
        sec = SecurityAttributes.new
        sec[:nLength] = SecurityAttributes.size
        sec[:bInheritHandle] = true
      else
        sec = nil
      end

      if name && name.encoding.to_s != 'UTF-16LE'
        name = name + 0.chr
        name.encode!('UTF-16LE')
      end

      handle = CreateMutexW(sec, initial_owner, name)

      if handle == 0 || handle == INVALID_HANDLE_VALUE
        raise SystemCallError.new("CreateMutex", FFI.errno)
      end

      super(handle)

      if block_given?
        begin
          yield self
        ensure
          close # From superclass
        end
      end
    end

    # Open an existing Mutex by +name+. The +inherit+ argument sets
    # whether or not the object was opened such that a process created by the
    # CreateProcess() function (a Windows API function) can inherit the
    # handle. The default is true.
    #
    # This method is essentially identical to Mutex.new, except that the
    # option for +initial_owner+ cannot be set (since it is already set).
    # Also, this method will raise a Mutex::Error if the mutex doesn't
    # already exist.
    #
    # If you want "open or create" semantics, then use Mutex.new.
    #
    def self.open(name, inherit=true, &block)
      if name.encoding.to_s != 'UTF-16LE'
        name = name + 0.chr
        name.encode!('UTF-16LE')
      end

      begin
        # The OpenMutex() call here is strictly to force an error if the user
        # tries to open a mutex that doesn't already exist.
        handle = OpenMutexW(MUTEX_ALL_ACCESS, inherit, name)

        if handle == 0 || handle == INVALID_HANDLE_VALUE
          raise SystemCallError.new("OpenMutex", FFI.errno)
        end
      ensure
        CloseHandle(handle) if handle && handle > 0
      end

      self.new(false, name, inherit, &block)
    end

    # Releases ownership of the mutex.
    #
    def release
      unless ReleaseMutex(@handle)
        raise SystemCallError.new("ReleaseMutex", FFI.errno)
      end
    end

    # Returns whether or not the calling thread has initial ownership of
    # the mutex object.
    #
    def initial_owner?
      @initial_owner
    end

    # Returns whether or not the object was opened such that a process
    # created by the CreateProcess() function (a Windows API function) can
    # inherit the handle. The default is true.
    #
    def inheritable?
      @inherit
    end
  end
end
