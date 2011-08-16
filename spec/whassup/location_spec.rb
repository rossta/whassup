require 'spec_helper'

describe Whassup::Location do

  before(:each) do
    @location = Whassup::Location.new('http://www.example.com')
    Curl::Easy.stub!(:http_get).and_return(mock(:response_code => 200))
  end

  describe "class methods" do
    before(:each) do
      Host.stub!(:ensure_registered!)
    end
    describe "find" do
      
      it "should return new location for url" do
        location = Location.find("http://www.example.com")
        location.url.should == 'http://www.example.com'
      end
    end
  end

  describe "url" do
    it "should create a new location at a url" do
      @location.url.should == 'http://www.example.com'
    end
  end

  describe "history" do

    it "should start empty" do
      @location.history.should be_empty
    end

    it "should return list of stored response codes" do
      @location.check
      @location.history.should == ["200"]
    end
  end

  describe "remove" do
    it "should empty history" do
      @location.check
      @location.remove
      @location.history.should be_empty
    end
  end

  describe "host" do
    it "should return url host" do
      @location.host.should == "www.example.com"
    end
  end

  describe "path" do
    it "should return url path" do
      @location.path.should == ""
    end
  end
end
