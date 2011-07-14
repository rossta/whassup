$LOAD_PATH.unshift 'lib'
require 'whassup/version'

Gem::Specification.new do |s|
  s.name              = "whassup"
  s.version           = Whassup::Version
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Whassup is a Redis-backed uptime monitoring service."
  s.homepage          = "http://github.com/rossta/whassup"
  s.email             = "rosskaff@gmail.com"
  s.authors           = [ "Ross Kaffenberger" ]

  s.files             = %w( README.markdown Rakefile LICENSE HISTORY.md )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  # s.files            += Dir.glob("test/**/*")
  s.executables       = [ "whassup", "whassup-web" ]

  s.extra_rdoc_files  = [ "LICENSE", "README.markdown" ]
  s.rdoc_options      = ["--charset=UTF-8"]

  s.add_dependency "redis-namespace", "~> 1.0.2"
  s.add_dependency "vegas",           "~> 0.1.2"
  s.add_dependency "sinatra",         ">= 1.0.0"
  s.add_dependency "curb"
  s.add_dependency "haml"
  s.add_dependency "sass"
  # s.add_dependency "json",            ">= 1.4.6", "< 1.6"

  s.description = <<-description
    Whassup is a Redis-backed Ruby service for monitoring uptime at
    specified urls.

    Whassup was created because I had a number of urls to monitor in different
    contexts and I didn't want to pay for something I could build myself. It is
    heavily inspired by Resque (which rocks) and is comprised of three parts:

    * A Ruby library for creating, querying, and monitoring urls
    * A Rake task for starting service
    * A Sinatra app for monitoring urls
description
end
