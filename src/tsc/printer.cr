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
    @connected : Bool

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
      @socket = uninitialized TCPSocket
      @connected = false
    end

    # Returns `true` if the printer is connected.
    def connected?
      @connected
    end

    # Establishes a TCP connection to the printer.
    def connect
      @socket = TCPSocket.new(@host, @port)
      @connected = true
    rescue e : Errno
      @connected = false
      raise ConnectionError.new(e.message)
    end

    def connect(&block)
      @socket = TCPSocket.new(@host, @port)
      @connected = true
      yield self
    rescue e : Errno
      raise ConnectionError.new(e.message)
    ensure
      @connected = false
      @socket.close
    end

    # Tears down the existing TCP connection to the printer.
    def disconnect
      @socket.close
      @connected = false
    end
  end
end
