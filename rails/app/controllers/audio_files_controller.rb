class AudioFilesController < ApplicationController
  before_action :set_audio_file
  before_action :encode_file, if: -> { !file_exists? }
  before_action :create_m3u8, if: -> { file_exists? && !m3u8_exists? }

  def show
    render json: {
      m3u8_exists: m3u8_exists?
    }
  end

  private
  def set_audio_file
    @audio_file = AudioFile.find(params[:id])
  end

  def file_exists?
    RedisDb.client.get("file:#{@audio_file.id}").nil? &&
      File.exist?(@audio_file.decorate.temp_file)
  end

  def encode_file
    if !RedisDb.client.get("file:#{@audio_file.id}")
      RedisDb.client.set("file:#{@audio_file.id}", "1")
      EncodeWorker.perform_async(@audio_file.id)
    end
  end

  def m3u8_exists?
    RedisDb.client.get("stream:#{@audio_file.id}").nil? &&
      File.exist?(@audio_file.decorate.m3u8_path)
  end

  def create_m3u8
    if !RedisDb.client.get("stream:#{@audio_file.id}")
      RedisDb.client.set("stream:#{@audio_file.id}", "1")
      StreamWorker.perform_async(@audio_file.id)
    end
  end
end
