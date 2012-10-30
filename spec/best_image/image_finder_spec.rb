require 'spec_helper'

module BestImage
  describe ImageFinder do 
    let(:good_url) { "http://www.google.com" }
    let(:bad_url) { "http://www.some-url-that-should-never-be-findable.com" }
    let(:good_image_url) { "http://www.google.com/intl/en_ALL/images/srpr/logo1w.png" }
    
    it "should fail gracefully and set an error message if it cannot access url" do
      best = BestImage::ImageFinder.new
      best.parse(bad_url)
      best.errors.should_not be_empty
    end
    
    it "should parse the passed url into a uri" do
      best = BestImage::ImageFinder.new
      best.send :set_uri, good_url
      best.send :set_response
      best.errors.empty?.should be_true
    end
    
    it "should collect an array of images found on the page" do
      best = BestImage::ImageFinder.new
      best.parse(good_url)
      best.images.should_not be_empty
    end
    
    it "should return the best image on a page" do
      test_url_match = "large"
      small = ImageReference.new(bad_url)
      small.stub!(:size).and_return(1)
      small.stub!(:url).and_return("small")
      medium = ImageReference.new(bad_url)
      medium.stub!(:size).and_return(2)
      medium.stub!(:url).and_return("medium")
      large = ImageReference.new(bad_url)
      large.stub!(:size).and_return(3)
      large.stub!(:url).and_return(test_url_match)
      
      best = BestImage::ImageFinder.new
      best.images << small
      best.images << large
      best.images << medium
      
      best.best_image.should eq(test_url_match)
    end
    
    it "should return nil for best_image if it has errors" do
      best = BestImage::ImageFinder.new
      best.instance_variable_set("@errors", ["not being nil"])
      best.best_image.should be_nil
    end
    
    it "should return nil for best_image if it has no images" do
      best = BestImage::ImageFinder.new
      best.stub!(:images).and_return([])
      best.best_image.should be_nil
    end
    
    it "should return nil for best_image if the largest image is <= 0" do
      small = ImageReference.new(bad_url)
      small.stub!(:size).and_return(0)
      
      best = BestImage::ImageFinder.new
      best.stub!(:images).and_return([small])
      best.best_image.should be_nil
    end

  end
end