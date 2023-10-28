class AudioFileDecorator < Draper::Decorator
  delegate_all
  def m3u8_path
    "/data/#{object.id}.m3u8"
  end
  def temp_file
    "/data/#{file_name}"
  end
  def file_name
    '%s.%s' % [object.id, format_name.downcase]
  end
  def public_path
    "#{BACKUP_SERVER_PATH}/#{path}"
  end
  def path
    [folder.decorate.path, object.name].join "/"
  end
  def format_name
    ALLOWED_AUDIO_FORMATS.detect { |_, format| format[:tags].any? { |tag| object.format_info =~ /#{tag}/ } }[0]
  end
end
