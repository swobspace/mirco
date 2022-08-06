# used in puml graphs
class NullInterfaceConnector
  attr_reader :name, :type, :url
  alias_attribute :id, :object_id

  def initialize(options = {})
    @options = options.symbolize_keys
    @name = @options.fetch(:name) { "Unknown" }
    @type = @options.fetch(:type)
    @url  = @options.fetch(:url)
  end

  InterfaceConnector.attribute_names.each do |attr_name|
    next if ["id", "name", "type", "url", "created_at", "updated_at"].include?(attr_name)
    define_method attr_name.to_sym do
      nil
    end
  end
end
