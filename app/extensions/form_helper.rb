module ActionView
  module Helpers
    module FormTagHelper
      def generate_input_for(video, metadata_info)
        value = video[metadata_info.name]
        read_only = metadata_info.read_only?
        options = { readonly: read_only }
        name = "video[#{metadata_info.name}]" # This is a little ugly ...

        case metadata_info.type
          when "number"
            number_field_tag name, value, options
          when "text"
            text_field_tag name, value, options
          when "range"
            range_field_tag name, value, options.merge(metadata_info.options)
          when "select"
            select_tag name, options_for_select(metadata_info.options[:values], value), options
          when "on_off"
            check_box_tag name, "1", value, options
          when "date"
            str_value = if value then value.strftime("%Y-%m-%d") else "" end
            date_field_tag name, str_value, options
          else
        end
      end
    end
  end
end
