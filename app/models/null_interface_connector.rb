# used in puml graphs
class NullInterfaceConnector
  attr_reader :name, :type, :url, :server_id, :host
  alias_attribute :id, :object_id

  def initialize(options = {})
    @options = options.symbolize_keys
    @name = @options.fetch(:name) { "Unknown" }
    @type = @options.fetch(:type)
    @url  = @options.fetch(:url)
    @server_id  = @options.fetch(:server_id)
    @host = fetch_host(@url)
  end

  def hostname
    host&.name
  end

  def host_id
    host&.id
  end

  def ipaddress
    host&.ipaddress.to_s
  end

  InterfaceConnector.attribute_names.each do |attr_name|
    next if ["id", "name", "type", "url", "server_id", "created_at", "updated_at"].include?(attr_name)
    define_method attr_name.to_sym do
      nil
    end
  end

  private

  def fetch_host(url)
    return nil if type == 'TxConnector'
    host = Mirco::Uri.new(url).host
    if !!(host =~ Regexp.union([Resolv::IPv4::Regex, Resolv::IPv6::Regex]))
      Host.where(ipaddress: host).first
    else
      nil
    end
  end
end
