class Audio
  include Mongoid::Document
  mount_uploader :file, AudioFileUploader
end
