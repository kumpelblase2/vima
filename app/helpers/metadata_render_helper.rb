module MetadataRenderHelper
  def render_metadata(metadata, value)
    if metadata.type == "taglist"
      render 'shared/metadata/taglist', tags: value
    elsif metadata.type == "duration"
      render 'shared/metadata/duration', time: value
    elsif metadata.type == 'on_off'
      value ? "Yes" : "No"
    else
      value
    end
  end

  def metadata_display_name(metadata)
    metadata.grouped_name.humanize + (
    if metadata.belongs_to_group? then
      " (#{metadata.group_name.humanize})"
    else
      ""
    end)
  end
end
