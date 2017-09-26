require "../src/tsc/printer"

printer = Tsc::Printer.new("192.168.1.160")
printer.connect

printer.cls
printer.direction(0, 0)
printer.box(16, 16, 440, 576, 4)
printer.barcode(105, 32, "39", 57, 1, 90, 2, 4, 0, "1234567890")
printer.text(121, 32, "0", 0, 30, 30, 0, "TEST")
printer.print(1)

printer.disconnect
