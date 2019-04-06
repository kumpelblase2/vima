class Settings
  include Mongoid::Document

  field :thumbnail_dir, type: String, default: ->{ ".thumbnails" }
  field :thumbnail_amount, type: Integer, default: ->{ 4 }
  field :home_video_count, type: Integer, default: ->{ 10 }
  field :default_order, type: String, default: ->{ "name" }
  field :default_order_direction, type: String, default: ->{ "asc" }

  def self.get_instance
    first_or_create!
  end
end
