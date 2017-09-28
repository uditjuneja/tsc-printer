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

      # Defines the printout direction and mirror image. This will be stored in
      # the printer memory.
      #
      # Acceptable values for *n* and *m* are 0 or 1. Please refer to the following diagram:
      # ![Direction diagram](/tsc-printer/images/setup/direction.png)
      #
      # ```
      # printer.direction(0, 0) # Top-first, no mirroring
      # printer.direction(1, 0) # Bottom-first, no mirroring
      # printer.direction(0, 1) # Top-first with mirroring
      # printer.direction(1, 1) # Bottom-first with mirroring
      # ```
      def direction(n : Int32, m : Int32)
        @socket << "#{DIRECTION} #{n},#{m}#{EOL}"
      end

      # Prints the label format currently stored in the image buffer.
      #
      # ```
      # # Three sets of two labels, grand total of six labels
      # printer.print(3, 2)
      # ```
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
