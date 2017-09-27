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
      def status : Symbol
        @socket << STATUS
        resp = @socket.read_byte
        Codemap::DETAILS[resp]
      end

      # This command restarts the printer and does not run AUTO.BAS.
      #
      # **Note:**
      # - When the printer receives this command, the printer will restart itself whether AUTO.BAS exists or not.
      #
      # **Since:**
      # - This command has been supported since V5.23 EZ and later firmware.
      def restart
        @socket << RESTART
      end

      # This command is used to disable immediate commands.
      def disable_immediate
        @socket << DISABLE_IMMEDIATE
      end

      # This command is used to cancel the pause status of printer.
      def unpause
        @socket << UNPAUSE
      end

      # This command is used to pause the printer.
      def pause
        @socket << PAUSE
      end

      # This command obtains detailed status information of the printer, even
      # in the event of printer error.
      #
      # **Since:**
      # - This command has been supported since V6.29 EZ and later firmware.
      #
      # ```
      # printer.status_detailed # => { message: :waiting_to_press_print_key, warning: :receive_buffer_full, printer_error: :print_head_error, media_error: :paper_empty }
      # ```
      def status_detailed : Hash(Symbol, Symbol)
        slice = Bytes.new(8)
        @socket << STATUS_DETAILED
        @socket.read(slice)

        Codemap.convert_detailed_status_response(slice)
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

      def cancel
        @socket << CANCEL
      end
    end
  end
end
