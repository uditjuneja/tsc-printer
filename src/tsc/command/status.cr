require "../codemap"

module Tsc
  module Command
    module Status
      STATUS                 = "\e!?"
      RESTART                = "\e!C"
      DISABLE_IMMEDIATE      = "\e!D"
      UNPAUSE                = "\e!O"
      PAUSE                  = "\e!P"
      RESTART_AUTO_BAS       = "\e!Q"
      RESET                  = "\e!R"
      STATUS_DETAILED        = "\e!S"
      FEED                   = "\e!F"
      CANCEL                 = "\e!."
      MILEAGE                = "\e~!@"
      MEMORY                 = "\e~!A"
      RTC                    = "\e~!C"
      DUMP                   = "\e~!D"
      IMMEDIATE              = "\e~!E"
      FILES                  = "\e~!F"
      CODE_PAGE_COUNTRY_CODE = "\e~!I"
      MODEL                  = "\e~!T"
      LINE_MODE_ENABLE       = "\eY"
      LINE_MODE_DISABLE      = "\eZ"

      # This command obtains the printer status at any time, even in the event
      # of printer error.
      #
      # ```
      # printer.status # => :normal
      # printer.status # => :ribbon_empty_head_open
      # ```
      def status
        @socket << STATUS
        resp = @socket.read_byte
        Codemap::DETAILS[resp]
      end

      # This command restarts the printer and does not run AUTO.BAS.
      #
      # **Notes:**
      # - When the printer receives this command, the printer will restart itself whether AUTO.BAS exists or not.
      # - This command has been supported since V5.23 EZ and later firmware.
      def restart
        @socket << RESTART
      end

      # This command is used to disable immediate commands.
      def disable_immediate
        @socket << DISABLE_IMMEDIATE
      end

      # This command is used to cancel the PAUSE status of printer.
      def unpause
        @socket << UNPAUSE
      end

      # This command is used to PAUSE the printer.
      def pause
        @socket << PAUSE
      end

      # This command obtains the printer status at any time, even in the event
      # of printer error.
      def status_detailed
        slice = Bytes.new(8)
        @socket << STATUS_DETAILED
        @socket.read(slice)

        return {
          message:       Codemap::MESSAGES[slice[1]],
          warning:       Codemap::WARNINGS[slice[2]],
          printer_error: Codemap::PRINTER_ERRORS[slice[3]],
          media_error:   Codemap::MEDIA_ERRORS[slice[4]],
        }
      end

      # This command resets the printer.
      def reset
        @socket << RESET
      end

      # This command retrieves the mileage of the printer. Only the integer part
      # of the mileage value is returned.
      def mileage
        @socket << MILEAGE
        resp = @socket.gets('\r', true)
        return resp.to_i if resp

        resp
      end

      # This command determines whether a Real Time Clock is installed in the printer.
      def has_rtc? : Bool
        @socket << RTC
        resp = @socket.read_byte

        return true if resp == '1'.ord
        false
      end
    end
  end
end
