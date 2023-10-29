module RedisDb
  class << self
    def client
      @client ||= Redis.new host: REDIS_HOST, port: REDIS_PORT, db: REDIS_DB
    end
  end
end
