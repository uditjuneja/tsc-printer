require "../spec_helper"

module Tsc
  describe Printer do
    it "is initializable" do
      printer = Printer.new("localhost")
    end

    it "has a socket" do
      printer = Printer.new("localhost")
      printer.socket.should_not eq nil
    end

    it "handles the size command" do
      printer = Printer.new("localhost")
      printer.socket = IO::Memory.new

      printer.size(12, 34)
      result = printer.socket.rewind.gets
      result.should eq "SIZE 12,34"
    end
  end
end
