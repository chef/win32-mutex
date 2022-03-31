require "win32/ipc"
module Win32
  class Mutex < Ipc
    # The version of the win32-mutex library
    VERSION = "0.4.4".freeze
  end
end
