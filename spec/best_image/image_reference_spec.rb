require 'spec_helper'

module BestImage
  describe ImageReference do 
    let(:good_url) { "http://www.google.com/intl/en_ALL/images/srpr/logo1w.png" }
    let(:bad_url) { "http://www.google.com/an/image/that/dosent/exist/logo1w.png" }
    
    it "should fail gracefully if it cannot get the image and return 0 for the size" do
      image = ImageReference.new(bad_url)
      image.size.should == 0
      image.errors.should_not be_empty
    end
    
    it "should calculate the size of the image and store it in the instance variable" do
      image = ImageReference.new(good_url)
      image.size.should_not == 0
      image.instance_variable_get("@size").should_not == 0
      image.errors.should be_empty, image.errors.inspect
    end
    
    
    it "should sort by size, smallest to largest" do
      small = ImageReference.new(bad_url)
      small.stub!(:size).and_return(1)
      medium = ImageReference.new(bad_url)
      medium.stub!(:size).and_return(2)
      large = ImageReference.new(bad_url)
      large.stub!(:size).and_return(3)
      
      (2 <=> 1).should == 1 
      (medium <=> (small)).should == 1
      (large <=> (small)).should == 1
      (large <=> (medium)).should == 1
      (large <=> (large)).should == 0
    end
    
  end
end
  