require "../src/tsc/printer"

printer = Tsc::Printer.new("192.168.1.160")
printer.connect do |p|
  p.cancel
  p.restart
end
