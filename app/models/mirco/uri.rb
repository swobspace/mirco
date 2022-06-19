module Mirco
  class Uri
    attr_accessor :url, :scheme, :host, :port, :path

    def initialize(url)
      @url = url
      parse_url
    end

    private

    def parse_url
      regex = Regexp.new('\A(\w+)://([^/\s:]*)(|:(\d+))?(/.*)\z')
      m = @url.match(regex)
      @scheme = m[1].downcase
      @host = m[2]
      @port = m[4]
      @path = m[5]
    end
  end
end
