class EncodeWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :default, :retry => true, :backtrace => true

  def perform audio_file_id
    audio_file = AudioFile.find(audio_file_id).decorate
    return if File.exist?(audio_file.temp_file)
    file = Down.download("#{BACKUP_SERVER_URL}/#{audio_file.path}")
    strip_metadata(file.path, audio_file.temp_file) if ['AAC', 'ALAC', 'MP3'].include?(audio_file.format_name)
    encode(file.path, audio_file.temp_file) if ['AIFF', 'WAV'].include?(audio_file.format_name)
    RedisDb.client.del("file:#{audio_file.id}")
  end

  private
  def strip_metadata source, destination
    `ffmpeg -y -i #{source} -map 0:a -codec:a copy -map_metadata -1 #{destination} -nostats -loglevel 0`
  end
  def encode source, destination
    `lame --silent -b 320 -ms #{source} #{destination}`
  end
end
