class FolderDecorator < Draper::Decorator
  delegate_all
  def path
    [read_attribute(:folder), subfolder, read_attribute(:source), name].compact.join "/"
  end
end
