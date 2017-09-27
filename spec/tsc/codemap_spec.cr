require "../spec_helper"

module Tsc
  describe Codemap do
    it "converts detailed status responses" do
      bytes = Bytes[0x02, 0x4B, 0x48, 0x44, 0x41, 0x03, 0x13, 0x10]
      expected = {
        message:       :waiting_to_press_print_key,
        warning:       :receive_buffer_full,
        printer_error: :print_head_error,
        media_error:   :paper_empty,
      }
      actual = Codemap.convert_detailed_status_response(bytes)
      expected.should eq actual
    end
  end
end
