class CsvFile
  include Mongoid::Document
  field :name, type: String

  mount_uploader :file, FileUploader
end
