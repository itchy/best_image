require 'spec_helper'

module BestImage
  describe ImageSelector do 
    let(:good_url) { "http://www.google.com" }
    
    it "should create a new ImageFinder and call parse with the passed parameter" do
      ImageFinder.should_receive(:new).with(good_url)
      ImageSelector.new(good_url)
    end
    
    it "should fail gracefully" do
      best = ImageSelector.new("badurl")
      best.best_image.should be_nil
    end
  end
end
  