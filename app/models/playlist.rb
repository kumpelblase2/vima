class Playlist
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  field :name

  index({ name: 1 }, { unique: true })
  validates_uniqueness_of :name

  has_and_belongs_to_many :videos, inverse_of: nil
end
