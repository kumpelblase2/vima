require 'digest/md5'

module FileHelper
  def self.get_file_hash(file)
    Digest::MD5.hexdigest(file)
  end
end
