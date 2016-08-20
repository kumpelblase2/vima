require 'digest/md5'

module FileHelper
  def self.get_file_hash(file)
    hex = Digest::MD5.hexdigest(File.read(file))
    pp hex
  end
end