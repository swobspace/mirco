module Mirco
  class Uri
    attr_accessor :url, :scheme, :host, :port, :path

    def initialize(url)
      @url = url || ""
      parse_url
    end

    def to_s
      if port.nil?
        "#{scheme}://#{host}#{path}"
      else
        "#{scheme}://#{host}:#{port}#{path}"
      end
    end

    private

    def parse_url
      regex = Regexp.new('\A(\w+)://([^/\s]*?)(|:(\d+))(|/.*)\z')
      m = @url.match(regex)
      if !m.nil?
        @scheme = m[1].to_s.downcase
        @host = m[2]
        @port = m[4]
        @path = m[5]
      end
    end
  end
end
