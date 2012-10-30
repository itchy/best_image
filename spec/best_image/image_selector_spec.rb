require 'spec_helper'

module BestImage
  describe ImageSelector do 
    let(:good_url) { "http://www.google.com" }
    
    it "should create a new ImageFinder and call parse with the passed parameter" do
      ImageFinder.should_receive(:new).with(good_url)
      ImageSelector.new(good_url)
    end
  end
end
  