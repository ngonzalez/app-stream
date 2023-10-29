class StreamWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :default, :retry => true, :backtrace => true

  def perform audio_file_id
    audio_file = AudioFile.find(audio_file_id).decorate
    return if File.exist?(audio_file.m3u8_path)
    create_m3u8(audio_file)
    RedisDb.client.del("stream:#{audio_file.id}")
  end

  private
  def create_m3u8 audio_file
    `ffmpeg -y \
    -i #{audio_file.temp_file} \
    -codec copy \
    -loglevel 0 \
    -map 0 \
    -f hls \
    -hls_time 10 \
    -hls_playlist_type vod \
    -hls_segment_filename "/data/#{audio_file.id}_%d.ts" \
    "/data/#{audio_file.id}.m3u8"`
  end
end
