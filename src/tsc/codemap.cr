module Tsc
  module Codemap
    DETAILS = {
      0x00 => :normal,
      0x01 => :head_opened,
      0x02 => :paper_jam,
      0x03 => :paper_jam_head_open,
      0x04 => :paper_empty,
      0x05 => :paper_empty_head_open,
      0x08 => :ribbon_empty,
      0x09 => :ribbon_empty_head_open,
      0x0A => :ribbon_empty_paper_jam,
      0x0B => :ribbon_empty_paper_jam_head_open,
      0x0C => :ribbon_empty_paper_empty,
      0x0D => :ribbon_empty_paper_empty_head_open,
      0x10 => :pause,
      0x20 => :printing,
      0x80 => :other_error,
    }

    MESSAGES = {
      0x40 => :normal,
      0x60 => :pause,
      0x42 => :backing_label,
      0x43 => :cutting,
      0x45 => :printer_error,
      0x46 => :form_feed,
      0x4B => :waiting_to_press_print_key,
      0x4C => :waiting_to_take_label,
      0x50 => :print_batch,
      0x57 => :imaging,
    }

    WARNINGS = {
      0x40 => :normal,
      0x41 => :reversed,
      0x42 => :reversed,
      0x44 => :reversed,
      0x48 => :receive_buffer_full,
      0x60 => :reversed,
    }

    PRINTER_ERRORS = {
      0x40 => :normal,
      0x41 => :print_head_overheat,
      0x42 => :stepping_motor_overheat,
      0x44 => :print_head_error,
      0x48 => :cutter_jam,
      0x60 => :insufficient_memory,
    }

    MEDIA_ERRORS = {
      0x40 => :normal,
      0x41 => :paper_empty,
      0x42 => :paper_jam,
      0x44 => :ribbon_empty,
      0x48 => :ribbon_jam,
      0x60 => :print_head_open,
    }
  end
end
