require "../src/tsc/printer"

printer = Tsc::Printer.new("192.168.1.160")
printer.connect do |p|
  pp p.model
  pp p.status
  pp p.has_rtc?
  pp p.free_memory
  pp p.mileage
  pp p.status_detailed
end
