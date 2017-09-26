require "../src/tsc/printer"

printer = Tsc::Printer.new("192.168.1.160")
printer.connect do |p|
  pp p.status
  pp p.mileage
  pp p.status_detailed
  pp p.has_rtc?
end
