module Tsc
  module Command
    # This module implements **Setup and System Commands**.
    module Setup
      SIZE           = "SIZE"
      GAP            = "GAP"
      GAPDETECT      = "GAPDETECT"
      BLINEDETECT    = "BLINEDETECT"
      AUTODETECT     = "AUTODETECT"
      BLINE          = "BLINE"
      OFFSET         = "OFFSET"
      SPEED          = "SPEED"
      DENSITY        = "DENSITY"
      DIRECTION      = "DIRECTION"
      REFERENCE      = "REFERENCE"
      SHIFT          = "SHIFT"
      COUNTRY        = "COUNTRY"
      CODEPAGE       = "CODEPAGE"
      CLS            = "CLS"
      FEED           = "FEED"
      BACKFEED       = "BACKFEED"
      BACKUP         = "BACKUP"
      FORMFEED       = "FORMFEED"
      HOME           = "HOME"
      PRINT          = "PRINT"
      SOUND          = "SOUND"
      CUT            = "CUT"
      LIMITFEED      = "LIMITFEED"
      SELFTEST       = "SELFTEST"
      EOJ            = "EOJ"
      DELAY          = "DELAY"
      DISPLAY        = "DISPLAY"
      INITIALPRINTER = "INITIALPRINTER"
      MENU           = "MENU"

      def cls
        @socket << CLS
        @socket << EOL
      end

      def direction(x : Int32, y : Int32)
        @socket << "#{DIRECTION} #{x},#{y}#{EOL}"
      end

      def print(sets : Int32, copies : Int32 = 0)
        @socket << "#{PRINT} #{sets}"
        @socket << ",#{copies}" if copies > 0
        @socket << EOL
      end

      # Defines the label width and length.
      #
      # **Since:**
      # - Dot units of measurement for this command has been supported since V6.27 EZ and later firmware.
      #
      # ```
      # # 3.5in x 3.0in label
      # printer.size(3.5, 3.0)
      #
      # # 100mm x 100mm label
      # printer.size(100, 100, Tsc::Unit::Mm)
      #
      # # 120dot x 120dot label
      # printer.size(120, 120, Tsc::Unit::Inch)
      # ```
      def size(width : Number, length : Number, unit : Tsc::Unit = Tsc::Unit::Inch)
        @socket << "#{SIZE} "
        case unit
        when Tsc::Unit::Inch
          @socket << "#{width},#{length}"
        when Tsc::Unit::Mm
          @socket << "#{width} mm,#{length} mm"
        when Tsc::Unit::Dot
          @socket << "#{width} dot,#{length} dot"
        end
        @socket << EOL
      end
    end
  end
end
