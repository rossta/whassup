require 'redis-namespace'

require 'whassup/version'
require 'whassup/location'
require 'whassup/host'

module Whassup
  extend self

  # Accepts:
  #   1. A 'hostname:port' String
  #   2. A 'hostname:port:db' String (to select the Redis db)
  #   3. A 'hostname:port/namespace' String (to set the Redis namespace)
  #   4. A Redis URL String 'redis://host:port'
  #   5. An instance of `Redis`, `Redis::Client`, `Redis::DistRedis`,
  #      or `Redis::Namespace`.
  def redis=(server)
    case server
    when String
      if server =~ /redis\:\/\//
        redis = Redis.connect(:url => server, :thread_safe => true)
      else
        server, namespace = server.split('/', 2)
        host, port, db = server.split(':')
        redis = Redis.new(:host => host, :port => port,
          :thread_safe => true, :db => db)
      end
      namespace ||= :whassup

      @redis = Redis::Namespace.new(namespace, :redis => redis)
    when Redis::Namespace
      @redis = server
    else
      @redis = Redis::Namespace.new(:whassup, :redis => server)
    end
  end

  def check(url)
    Location.check(url)
  end

  def history(url = nil)
    Location.history(url)
  end

  def remove(url)
    Location.remove(url)
  end

  # Returns the current Redis connection. If none has been created, will
  # create a new one.
  def redis
    return @redis if @redis
    self.redis = Redis.respond_to?(:connect) ? Redis.connect : "localhost:6379"
    self.redis
  end

  def sites
    Location.all
  end

  def push(key, value)
    redis.lpush(key, value)
    redis.ltrim(key, 0, 10)
  end

  def range(key)
    redis.lrange(key, 0, 10)
  end

  def delete(key)
    redis.del(key)
  end

end