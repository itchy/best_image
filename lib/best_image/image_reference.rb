module BestImage
  class ImageReference
    attr_accessor :errors
    attr_reader :url
    
    def initialize(url)
      @errors = []
      @url = url
    end
    
    def size
      @size ||= calculate_file_size
    end
    
    def <=>(other)
      self.size <=> other.size
    end
    
    private
      def calculate_file_size
        open(URI.encode(@url), 'rb') do |fh|
          h,w = ImageSize.new(fh).size
          h*w
        end
        rescue OpenURI::HTTPError => e
          self.errors << e
          0
      end
  end
end