require "../src/tsc/printer"

printer = Tsc::Printer.new("192.168.1.160")
printer.connect

pp printer.status
pp printer.mileage
pp printer.status_detailed
pp printer.has_rtc?

printer.disconnect
