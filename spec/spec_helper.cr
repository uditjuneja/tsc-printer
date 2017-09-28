require "spec"
require "../src/tsc/*"

module Tsc
  class Printer
    property socket : TCPSocket | IO::Memory
  end
end
