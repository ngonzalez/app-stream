class Image < ImageBase
  belongs_to :folder, class_name: "Folder", foreign_key: :folder_id

  dragonfly_accessor :file do
    storage_options {|a| { path: "img/%s" % [ UUID.new.generate ] } }
    copy_to(:thumb){|a| a.thumb("600x500>") }
  end

  dragonfly_accessor :thumb do
    storage_options {|a| { path: "thumb/%s" % [ UUID.new.generate ] } }
  end
end
