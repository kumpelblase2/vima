module ActionView
  module Helpers
    module FormTagHelper
      def generate_input_for(video, metadata_info)
        value = video[metadata_info.name]

        case metadata_info.type
          when "number"
            number_field_tag metadata_info.name, value
          when "text"
            text_field_tag metadata_info.name, value
          when "range"
            range_field_tag metadata_info.name, value, metadata_info.options
          when "select"
            select_tag metadata_info.name, options_for_select(metadata_info.options["values"], value)
          when "on_off"
            check_box_tag metadata_info.name, "1", value
          else
        end
      end
    end
  end
end
