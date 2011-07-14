module Whassup

  class Host

    def self.all
      Array(Whassup.redis.smembers(:sites)).map { |host| find(host) }.compact
    end

    def self.exists?(host)
      Whassup.redis.sismember(:sites, host)
    end

    def self.register(host)
      Whassup.redis.sadd(:sites, host)
    end

    def self.ensure_registered!(host)
      register(host) if !exists?(host)
    end

    def initialize(host)
      @host = host
    end

    def to_s
      @host
    end
    alias_method :id, :to_s

  end
end