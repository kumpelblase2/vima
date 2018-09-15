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
        Metadata.new("points", "number", true, {}, 'desc')
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
    case scoring
    when Hash
      compute_points_from_hash metadata_value, scoring
    when Numeric
      compute_points_from_number metadata_value, scoring
    else
      0
    end
  end

  def compute_points_from_hash(metadata_value, scoring)
    case metadata_value
    when Boolean
      scoring[metadata_value.to_s] || 0
    when Array
      if metadata_value.empty?
        scoring['_empty'] || 0
      else
        metadata_value.map { |value| scoring[value] || 0 }.sum
      end
    when Numeric
      scoring.sort_by { |key,_value| key }.reverse.find([0]) { |elem| metadata_value >= elem.first }.last
    when String
      scoring[metadata_value] || 0
    else
      0
    end
  end

  def compute_points_from_number(metadata_value, scoring)
    case metadata_value
    when Numeric
      metadata_value * scoring
    when Boolean
      (metadata_value ? scoring : 0)
    else
      0
    end
  end
end

MetadataProviderList.instance.register "PointsProvider", VideoPointsProvider
