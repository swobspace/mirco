# frozen_string_literal: true

# rubocop:todo Rails/UniqueValidationWithoutIndex, Rails/InverseOf
class Channel < ApplicationRecord
  include EscalationStatusConcerns
  include NotableConcerns
  include Mirco::Condition

  # -- associations
  belongs_to :server
  has_one :channel_statistic, -> { where(meta_data_id: nil) }
  has_many :channel_statistics, dependent: :destroy
  has_many :channel_counters, dependent: :delete_all
  has_many :alerts, dependent: :destroy
  has_many :all_notes, class_name: 'Note', dependent: :destroy, inverse_of: :channel
  has_many :escalation_levels, as: :escalatable, dependent: :destroy

  # -- configuration
  store_accessor :properties, :name
  store_accessor :properties, :description
  store_accessor :properties, :revision
  store_accessor :properties, :version
  store_accessor :properties, :exportData
  store_accessor :properties, :sourceConnector
  store_accessor :properties, :destinationConnectors
  store_accessor :properties, :deployScript
  store_accessor :properties, :undeployScript
  store_accessor :properties, :preprocessingScript
  store_accessor :properties, :postprocessingScript

  # -- validations and callbacks
  validates :uid, presence: true, uniqueness: { scope: :server_id }
  before_save :check_enabled
  before_save :update_condition

  delegate :location, :ipaddress, to: :server

  scope :active, -> { where(enabled: true) }

  def to_s
    name.to_s
  end

  def fullname
    "#{server.to_s} > #{name}  [#{id}]"
  end

  def source_connector
    @source_connector ||= Mirco::Connector.new(sourceConnector, channel: self) if sourceConnector.present?
  end

  def destination_connectors
    @destination_connectors ||= if destinationConnectors.present?
                                  dconns = destinationConnectors['connector']
                                  if dconns.is_a? Array
                                    dconns
                                  else
                                    [dconns]
                                  end
                                else
                                  []
                                end.map { |c| Mirco::Connector.new(c, channel: self) }
  end

  def subchannels(channel = self)
    channels = []
    channel.destination_connectors.map do |conn|
      if conn.destination_channel_id
        ch = Channel.find(conn.destination_channel_id)
        next if ch.disabled?
        channels << ch.subchannels
        channels << ch
      end
    end
    channels.compact.flatten.uniq
  end

  def puml
    {
      alias: "ch_#{id}",
      text: name.to_s
    }
  end

  def disabled?
    !enabled
  end

  def has_attachment_handler?
    begin
      !properties['properties']['attachmentProperties']['properties'].nil?
    rescue
      false
    end
  end

  def escalatable_attributes
    %w[ updated_at ]
  end

  def update_condition
    if !(enabled?)
      set_condition(Mirco::States::NOTHING,
                    "Channel is disabled")
    else
      if escalation_status.state <= Mirco::States::OK
        set_condition(Mirco::States::OK,
                      I18n.t(Mirco::States::OK, scope: 'mirco.condition'))
      else
        set_condition(escalation_status.state,
                      escalation_status.message)
      end
    end
  end


  private

  # check_enabled
  # test for exportData first. If missing, use state from channel/statuses
  #
  def check_enabled
    if properties.nil?
      is_enabled = nil
    else
      is_enabled = properties.dig('exportData', 'metadata', 'enabled')
    end
    if is_enabled == 'true'
      self[:enabled] = true
    elsif is_enabled == 'false'
      self[:enabled] = false
    else
      case state
      when "STARTED", "STOPPED"
        self[:enabled] = true
      when "UNDEPLOYED"
        self[:enabled] = false
      else
        self[:enabled] = false
      end
    end
  end

end
# rubocop:enable Rails/UniqueValidationWithoutIndex, Rails/InverseOf
