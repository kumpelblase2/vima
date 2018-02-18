class Playlist
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  field :name

  index({ name: 1 }, { unique: true })
  validates_uniqueness_of :name

  has_and_belongs_to_many :videos, inverse_of: nil


  def video_after(video)
    current_index = self.videos.index(video)
    next_index = current_index + 1
    if next_index < self.videos.size
      self.videos[next_index]
    end
  end
end
