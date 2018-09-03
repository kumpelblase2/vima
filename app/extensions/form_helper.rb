module ActionView
  module Helpers
    module FormTagHelper
      def generate_input_for(video, metadata_info)
        value = video[metadata_info.name]
        read_only = metadata_info.read_only?
        options = {readonly: read_only, class: 'input' }
        name = "video[#{metadata_info.name}]" # This is a little ugly ...

        case metadata_info.type
          when "number"
            number_field_tag name, value, options
          when "text"
            text_field_tag name, value, options
          when "range"
            options[:class] = 'range'
            value = value || 0
            range_field_tag name, value, options.merge(metadata_info.options)
          when "select"
            tag.div(class: 'select') do
              select_tag name, options_for_select(metadata_info.options[:values], value), options
            end
          when "on_off"
            options[:class] = ''
            check_box_tag name, "1", value, options
          when "date"
            str_value = ( value ? value.strftime("%Y-%m-%d %H:%M:%S") : "" )
            datetime_field_tag name, str_value, options
          when "time"
            time_field_tag name, value, options
          when "taglist"
            selected_values = options_from_collection_for_select(MetadataHelper.get_values_for_metadata(metadata_info.name), 'to_s', 'to_s', value)
            value = value || []
            selected_data = { metadata: metadata_info.name, value: value.join(',') }
            options[:class] = 'taglist'
            tag.div(class: %(select is-multiple)) do
              select_tag name + "[]", selected_values, options.merge({ data: selected_data, multiple: 'multiple', style: 'width: 100%' })
            end
          else
        end
      end
    end
  end
end
