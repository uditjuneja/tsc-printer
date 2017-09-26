module Tsc
  module Command
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

      # This command defines the label width and length.
      def size(width : Int32, length : Int32, unit : Tsc::Unit = Inch)
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
