class FolderDecorator < Draper::Decorator
  delegate_all
  def public_path
    "#{BACKUP_SERVER_PATH}/#{path}"
  end
  def path
    [read_attribute(:folder), subfolder, read_attribute(:source), name].compact.join "/"
  end
end
