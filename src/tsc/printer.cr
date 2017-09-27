require "socket"
require "./command"
require "./error"

module Tsc
  # A `Tsc::Printer` allows for communicating with a TSC printer over the network.
  #
  # ```
  # printer = Tsc::Printer.new("1.2.3.4")
  # printer.connect do |p|
  #   p.cls
  #   p.direction(0, 0)
  #   p.text(121, 32, "0", 0, 30, 30, 0, "TEST")
  #   p.print(1)
  # end
  # ```
  class Printer
    include Command::Label
    include Command::Setup
    include Command::Status

    property host : String
    property port : Int32 = 9100
    property socket : TCPSocket | IO::Memory

    # Creates a new, not-yet-connected printer instance.
    #
    # ```
    # # A network printer located at hostname.example.com
    # printer = Printer.new("hostname.example.com")
    #
    # # A network printer by IP address
    # printer = Printer.new("1.2.3.4")
    #
    # # A network printer by IP address with custom port
    # printer = Printer.new("1.2.3.4", 56789)
    # ```
    def initialize(@host, @port = 9100)
      @socket = TCPSocket.new
    end

    # Establishes a connection to the printer.
    #
    # ```
    # printer = Printer.new("1.2.3.4")
    # printer.connect
    # ```
    def connect
      @socket.connect(@host, @port)
    rescue e : Errno
      raise ConnectionError.new(e.message)
    ensure
      @socket.close
    end

    # Establishes a connection to the printer, and yields the printer instance
    # to the block. The connection will be closed automatically when the block
    # returns.
    #
    # ```
    # printer = Printer.new("1.2.3.4")
    # printer.connect do |p|
    #   ...
    # end
    # ```
    def connect(&block)
      @socket.connect(@host, @port)
      yield self
    rescue e : Errno
      raise ConnectionError.new(e.message)
    ensure
      @socket.close
    end

    # Closes an established connection to a printer.
    #
    # ```
    # printer = Printer.new("1.2.3.4")
    # printer.connect
    # ...
    # printer.disconnect
    # ```
    def disconnect
      @socket.close
    end
  end
end
