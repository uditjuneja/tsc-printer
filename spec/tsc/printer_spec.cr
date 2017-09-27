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
  end
end
