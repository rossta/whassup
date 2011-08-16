require 'spec_helper'

describe "Whassup" do
  
  # class TestApp < Sinatra::Base
  #   get "/" do
  #     return "hello"
  #   end
  # end
  
  before(:each) do
    Whassup.redis.flushall
  end

  it "can set a namespace through a url-like string" do
    Whassup.redis = 'localhost:9736/namespace'
    'namespace'.should == Whassup.redis.namespace
  end
end
