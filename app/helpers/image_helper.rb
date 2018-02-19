require 'streamio-ffmpeg'

module ImageHelper
  RESOLUTION = "640x480"

  def self.generate_thumbnails(video, amount, output_format, quality = 5)
    movie = FFMPEG::Movie.new(video)
    if movie.valid?
      times = generate_image_times movie.duration, amount
      times.map do |time|
        filename = output_format % time
        movie.screenshot filename, { resolution: RESOLUTION, quality: quality }, { input_options: { ss: time.to_s } }
        filename
      end
    else
      []
    end
  end

  def self.generate_image_times(full_duration, amount)
    start_time, end_time = full_duration > 30 ? [10, full_duration - 10] : [0, full_duration]

    usable_length = end_time - start_time
    amount_split = (usable_length / amount).to_i
    (1..amount).map do |i|
      split_end = start_time + (i * amount_split)
      split_start = start_time + ((i - 1) * amount_split)
      rand(split_start..split_end)
    end
  end
end
