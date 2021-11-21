module Mirco
  class DashboardStatus
    attr_reader :name, :channel_uid, :state, :status_type, :queued, :statistics,
                :meta_data_id 
    ATTRIBUTES = [ :name, :channel_uid, :state, :status_type, :queued,
                   :meta_data_id, :received, :sent, :filtered, :error ]

    # Mirco::DashboardStatus.new(doc)
    # doc = Nokogiri::XML(<xml>)
    # i.e. 
    # <list>
    #   <dashboardStatus>
    #   ....
    #   </dashboardStatus>
    # </list>
    #
    def initialize(doc)
      @name = doc.xpath("name").text
      @channel_uid = doc.xpath("channelId").text
      @state = doc.xpath("state").text
      @status_type = doc.xpath("statusType").text
      @queued = doc.xpath("queued").text.to_i
      m_id = doc.xpath("metaDataId")&.text
      @meta_data_id = ( m_id.blank?  ? nil : m_id.to_i )
      @statistics = fetch_statistics(doc.xpath("statistics/entry"))
    end

    # Mirco::DashboardStatus.parse_xml(xml)
    # parses a xml document from https://mirth/api/channels/statuses
    # an returns an array of Mirco::DashboardStatus objects
    def self.parse_xml(xml)
      doc = Nokogiri::XML(xml)
      [].tap do |arry|
        doc.xpath("/list/dashboardStatus").each do |ch|
          arry << Mirco::DashboardStatus.new(ch)
          ch.xpath("childStatuses/dashboardStatus").each do |conn|
            arry << Mirco::DashboardStatus.new(conn)
          end
        end
      end
    end

    def received
      statistics['RECEIVED'].to_i
    end

    def filtered
      statistics['FILTERED'].to_i
    end

    def sent
      statistics['SENT'].to_i
    end

    def error
      statistics['ERROR'].to_i
    end

    def attributes
      {}.tap do |hash|
        ATTRIBUTES.each do |attr|
          hash[attr.to_s] = send(attr)
        end
      end
    end

  private

    def fetch_statistics(doc)
      {}.tap do |hash|
        doc.each do |entry|
          key = entry.xpath("com.mirth.connect.donkey.model.message.Status").text
          value = entry.xpath("long").text.to_i
          hash[key] = value
        end
      end
    end

  end
end
