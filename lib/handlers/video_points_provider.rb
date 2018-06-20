class VideoPointsProvider < MetadataProvider
  def initialize
    super
    @points_matrix = {}
  end

  def configure(config)
    @points_matrix = config

    on_video_update do |video|
      recalculate_points video
    end

    on_video_load do |video|
      recalculate_points video
    end

    @metadata = [
        Metadata.new("points", "number", true)
    ]
  end

  def recalculate_points(video)
    points = 0
    @points_matrix.each do |key,value|
      video_metadata_value = video[key]
      points += compute_points_for video_metadata_value, value
    end

    video[:points] = points
  end

  def compute_points_for(metadata_value, scoring)
    if metadata_value.is_a?(Numeric) then
      metadata_value * scoring
    elsif metadata_value.is_a?(String) then
      scoring[metadata_value]
    elsif metadata_value.is_a?(Array) then
      metadata_value.map { |value| scoring[value] }.sum
    elsif metadata_value.is_a?(Boolean) then
      metadata_value ? scoring : 0
    else
      0
    end
  end
end

MetadataProviderList.instance.register "PointsProvider", VideoPointsProvider
