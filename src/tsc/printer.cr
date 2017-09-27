require "socket"
require "./command"
require "./error"

module Tsc
  class Printer
    include Command::Label
    include Command::Setup
    include Command::Status

    property host : String
    property port : Int32 = 9100
    property socket : TCPSocket

    # Creates a new, not-yet-connected printer instance.
    #
    # ```
    # # A network printer located at hostname.example.com
    # p = Printer.new("hostname.example.com")
    #
    # # A network printer by IP address
    # p = Printer.new("192.168.1.123")
    #
    # # A network printer by IP address with custom port
    # p = Printer.new("192.168.1.123", 1234)
    # ```
    def initialize(@host, @port = 9100)
      @socket = TCPSocket.new
    end

    # Establishes a TCP connection to the printer.
    def connect
      @socket.connect(@host, @port)
    rescue e : Errno
      raise ConnectionError.new(e.message)
    ensure
      @socket.close
    end

    def connect(&block)
      @socket.connect(@host, @port)
      yield self
    rescue e : Errno
      raise ConnectionError.new(e.message)
    ensure
      @socket.close
    end

    # Tears down the existing TCP connection to the printer.
    def disconnect
      @socket.close
    end
  end
end
