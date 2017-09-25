require "../spec_helper"

module Tsc
  describe Printer do
    it "is initializable" do
      printer = Printer.new("localhost")
      printer.connected?.should be_false
    end
  end
end
