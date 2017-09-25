module Tsc
  module Command
    module Label
      BAR       = "BAR"
      BARCODE   = "BARCODE"
      TLC39     = "TLC39"
      BITMAP    = "BITMAP"
      BOX       = "BOX"
      CIRCLE    = "CIRCLE"
      ELLIPSE   = "ELLIPSE"
      CODABLOCK = "CODABLOCK"
      DMATRIX   = "DMATRIX"
      ERASE     = "ERASE"
      MAXICODE  = "MAXICODE"
      PDF417    = "PDF417"
      AZTEC     = "AZTEC"
      MPDF417   = "MPDF417"
      PUTBMP    = "PUTBMP"
      PUTPCX    = "PUTPCX"
      QRCODE    = "QRCODE"
      RSS       = "RSS"
      REVERSE   = "REVERSE"
      DIAGONAL  = "DIAGONAL"
      TEXT      = "TEXT"
      BLOCK     = "BLOCK"

      # This command draws rectangles on the label.
      #
      # **Note**:
      #  - Recommended max thickness of box is 12 mm at 4" width. Thickness of box
      # larger than 12 mm may damage the power supply and affect the print
      # quality. Max. print ratio is different for each printer model. Desktop
      # and industrial printer print ratio is limited to 20% and 30%
      # respectively.
      def box(x : Int32, y : Int32, x_end : Int32, y_end : Int32, thickness : Int32, radius : Int32 = 0)
        @socket << BOX
        @socket << " "
        @socket << "#{x},#{y},#{x_end},#{y_end},#{thickness}"
        @socket << ",#{radius}" if radius > 0
      end

      # This command prints 1D barcodes.
      def barcode(x : Int32, y : Int32, code_type : String, height : Int32, human_readable : Int32, rotation : Int32, narrow : Int32, wide : Int32, alignment : Int32, content : String)
        @socket << BARCODE
        @socket << " "
        @socket << " #{x},#{y},"
        @socket << '"'
        @socket << code_type
        @socket << '"'
        @socket << ",#{human_readable},#{rotation},#{rotation},#{narrow},#{wide},#{alignment},"
        @socket << '"'
        @socket << content
        @socket << '"'
      end

      # This command prints text on the label.
      def text(x : Int32, y : Int32, font : String, rotation : Int32, x_multiplication : Int32, y_multiplication : Int32, alignment : Int32, content : String)
        @socket << TEXT
        @socket << " "
        @socket << " #{x},#{y},"
        @socket << '"'
        @socket << font
        @socket << '"'
        @socket << ",#{rotation},#{x_multiplication},#{y_multiplication},#{alignment},"
        @socket << '"'
        @socket << content
        @socket << '"'
      end
    end
  end
end
