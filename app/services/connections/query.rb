##
# Query for Connections
#
module Connections
  class Query
    attr_reader :search_options, :query

    ##
    # possible search options:
    # * :source_url - string
    # * :destination_url - string
    # * :source_connector_id - integer
    # * :destination_connector_id - integer
    # * :location_id - integer
    # * :ignore - boolean
    # * :ignore_reason - string
    # * :description - string
    # * :channel_id - integer
    # * :id - integer
    # * :limit - limit result (integer)
    #
    # please note:
    #   .joins(source_connector: {software_interface: :software}, 
    #          destination_connector: {software_interface: :software} )
    # must exist in relation
    #
    def initialize(relation, search_options = {})
      @relation       = relation
      @search_options = search_options.symbolize_keys
      @limit          = 0
      @query          ||= build_query
    end

    ##
    # get all matching activities
    def all
      query
    end

    ## 
    # iterate with block 
    def find_each(&block)
      query.find_each(&block)
    end

    ##
    def include?(ta)
      query.where(id: ta.id).limit(1).any?
    end

  private
    attr_accessor :relation, :limit

    def build_query
      query = relation
      search_string = [] # for global search_option :search
      search_value  = search_options.fetch(:search, false) # for global option :search
      search_options.each do |key,value|
        case key 
        when *string_fields
          query = query.where("software_connections.#{key} LIKE ?", "%#{value}%")
        # 1:1 matching
        when *id_fields
         query = query.where(key.to_sym => value)
        when :channel_id
          query = query.where(":cid = ANY(software_connections.channel_ids)", cid: value.to_i)
        when :ignore
          query = query.where(ignore: to_boolean(value))
        when :limit
          @limit = value.to_i
        when :search
          string_fields.each do |term|
            search_string << "tasks.#{term} LIKE :search"
          end
        else
          raise ArgumentError, "unknown search option #{key}"
        end
      end
      if search_value
        query = query.where(search_string.join(' or '), search: "%#{search_value}%")
       end
      if limit > 0
        query.limit(limit)
      else
        # Rails.logger.debug("DEBUG:: query #{query.to_sql}")
        query
      end
    end

  private

    def string_fields
      [ :source_url, :destination_url, :ignore_reason ]
    end

    def id_fields
      [:source_connector_id, :destination_connector_id, :id]
    end

    def to_boolean(value)
      return true if ['ja', 'true', '1', 'yes', 'on', 't'].include?(value.to_s.downcase)
      return false if ['nein', 'false', '0', 'no', 'off', 'f'].include?(value.to_s.downcase)
      return nil
    end
  end
end
