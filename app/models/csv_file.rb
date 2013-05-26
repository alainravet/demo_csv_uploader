class CsvFile
  include Mongoid::Document
  field :name, type: String
  field :data_for_export, type: String

  mount_uploader :file, FileUploader
end
