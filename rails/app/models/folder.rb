class Folder < ActiveRecord::Base
  self.table_name = :folders

  has_many :audio_files, class_name: "AudioFile", dependent: :destroy, foreign_key: :folder_id
end
