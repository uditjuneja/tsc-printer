require "../src/tsc/printer"

printer = Tsc::Printer.new("192.168.1.160")
printer.connect do |p|
  p.cls
  p.direction(0, 0)
  p.box(16, 16, 440, 576, 4)
  p.barcode(105, 32, "39", 57, 1, 90, 2, 4, 0, "1234567890")
  p.text(121, 32, "0", 0, 30, 30, 0, "TEST")
  p.print(1)
end
