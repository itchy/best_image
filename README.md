# BestImage

This gem accepts a url and returns the *best image* found on that page.  Best is determined by largest at this time, but in the future I would like to look for FaceBook meta tags that allow the publisher to set the best image.

## Installation

Add this line to your application's Gemfile:

    gem 'best_image'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install best_image

## Usage
    require 'best_image'

    image_selector = BestImage::ImageSelector.new("http://www.path/to/page")

    if image_selector.best_image   
      @best_image = image_selector.best_image   
    else   
      # do defalut action in case network is down etc.   
      image_selector.errors   
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
