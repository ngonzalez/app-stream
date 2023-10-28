class AudioFile < ActiveRecord::Base
  self.table_name = :audio_files

  belongs_to :folder, class_name: "Folder", foreign_key: :folder_id
end
