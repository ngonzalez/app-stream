class AudioFile < ActiveRecord::Base
  self.table_name = :audio_files

  belongs_to :folder, class_name: "Folder", foreign_key: :folder_id

  has_paper_trail

  acts_as_paranoid
end
