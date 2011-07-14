require 'uri'
require 'curb'

module Whassup

  class Location

    def self.check(url)
      find(url).check
    end

    def self.remove(url)
      find(url).remove
    end

    def self.history(url = nil)
      locations = url.nil? ? all : [find(url)]
      {}.tap do |entries|
        locations.each do |location|
          entries[location] = location.history
        end
      end
    end

    def self.find(url)
      location = new(url)
      Host.ensure_registered!(location.host)
      location
    end

    def self.all
      results = Array(Whassup.redis.keys("urls:*")).map { |url| find(url.sub("urls:", "")) }.compact
      results
    end

    attr_accessor :url
    def initialize(url)
      @url = url
    end

    def history
      Whassup.range(key) || []
    end

    def check
      code = curl.response_code
      Whassup.push(key, code)
      code
    end

    def reset
      Whassup.empty(key)
    end

    def remove
      Whassup.delete(key)
    end

    def host
      parsed_url.host
    end

    def path
      parsed_url.path
    end

    def to_s
      url
    end
    alias_method :id, :to_s

    def key
      ["urls", url].join(":")
    end

    protected

    def curl
      Curl::Easy.http_get(url)
    end

    def parsed_url
      @parsed_url ||= URI.parse(url)
    end

  end
end