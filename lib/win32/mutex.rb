require 'win32/ipc'

# The Win32 module serves as a namespace only.
module Win32
   
   # The Mutex class encapsulates Windows mutex objects.
   class Mutex < Ipc
   
      # This is the error raised if any of the Mutex methods fail.
      class Error < StandardError; end
   
      extend Windows::Synchronize
      extend Windows::Error
      extend Windows::Handle
      
      # The version of the win32-mutex library
      VERSION = '0.3.1'
      
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
         
         # Used to prevent potential segfaults.
         if name && !name.is_a?(String)
            raise TypeError, 'name must be a string'
         end
         
         if inherit
            sec = 0.chr * 12 # sizeof(SECURITY_ATTRIBUTES)
            sec[0,4] = [12].pack('L')
            sec[8,4] = [1].pack('L') # 1 == TRUE
         else
            sec = 0
         end
         
         initial = initial_owner ? 1 : 0
         
         handle = CreateMutex(sec, initial, name)
         
         if handle == 0 || handle == INVALID_HANDLE_VALUE
            raise Error, get_last_error
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
         if name && !name.is_a?(String)
            raise TypeError, 'name must be a string'
         end
         
         bool = inherit ? 1 : 0

         # The OpenMutex() call here is strictly to force an error if the user
         # tries to open a mutex that doesn't already exist.
         begin
            handle = OpenMutex(MUTEX_ALL_ACCESS, bool, name)

            if handle == 0 || handle == INVALID_HANDLE_VALUE
               raise Error, get_last_error
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
            raise Error, get_last_error   
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
