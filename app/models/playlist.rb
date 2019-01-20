class Playlist
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  field :name

  index({ name: 1 }, { unique: true })
  validates_uniqueness_of :name

  has_and_belongs_to_many :videos, inverse_of: nil

  def as_playlist_param
    { playlist: self.id }
  end

  def ordered_videos
    videos.sort_by do |video|
      video_ids.index video.id
    end
  end

  def has_video(video_id)
    videos.any? {|video| video.id.eql? video_id}
  end

  def add_videos(video_ids)
    video_ids.each { |id|
      self.videos << Video.find(id) unless has_video(id)
    }
  end
end
