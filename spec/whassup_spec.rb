require 'spec_helper'

describe "Whassup" do
  
  class TestApp < Sinatra::Base
    get "/" do
      return "hello"
    end
  end
  
  it "should be ping test app" do
    
  end

end
