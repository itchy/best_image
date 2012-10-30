# This class is created as a convience class for creating and parsing at the same time
# seperating these functions in ImageFinder provided a conviencience for testing

module BestImage
  class ImageSelector < ImageFinder
    def initialize(path)
      super()
      parse(path)
    end
  end
end