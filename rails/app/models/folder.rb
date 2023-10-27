class Folder < ActiveRecord::Base
  self.table_name = :folders

  has_many :audio_files, class_name: "AudioFile", dependent: :destroy, foreign_key: :folder_id

  has_many :images, class_name: "Image", dependent: :destroy, foreign_key: :folder_id

  has_paper_trail

  acts_as_paranoid
end
