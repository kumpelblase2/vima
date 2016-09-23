require 'digest/md5'

module FileHelper
  def self.get_file_hash(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end