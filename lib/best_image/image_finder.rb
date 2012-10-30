module BestImage
  class ImageFinder
    attr_accessor :images, :errors, :messages
    
    def initialize
      @errors = [];  @messages = []; @images = []
    end
    
    def parse(path)
      set_uri(path)
      set_response
      set_doc
      set_images
      rescue IOError => e
        self
    end
    
    def best_image
      @best_image ||= calculate_best_image
    end
    
    private
    
      def calculate_best_image
        return nil unless @errors.empty?
        return nil if @images.empty?
        best_image = self.images.sort.last
        return nil unless best_image.size > 0
        best_image.url
      end
      
      def set_uri(path)
        @uri = URI.parse(path)
      end
      
      def set_response
        @response = Net::HTTP.get_response(@uri)
        rescue Timeout::Error => e
          self.errors << e
          self.messages << "A Timeout error occured while trying to access #{@uri}"
          raise IOError
        rescue SocketError => e
          self.errors << e
          self.messages << "An error occured trying to access #{@uri}"
          raise IOError
      end
      
      def set_doc
        return unless @response
        @doc = Nokogiri::HTML(@response.body)
      end
      
      def set_images
        return unless @doc
        image_links = @doc.css('img')
        self.images = image_links.map do |link| 
          src = full_path(link[:src]) 
          ImageReference.new(src)
        end
      end
      
      def full_path(image)
        if image[/^\//]
          "http://#{@uri.host}#{image}"
        else
          image
        end
      end
  end
end
