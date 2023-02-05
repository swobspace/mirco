# frozen_string_literal: true

class Channel::AttachmentHandlerComponent < ViewComponent::Base
  def initialize(channel:)
    @channel = channel
    @attachment_properties = @channel.properties['properties']['attachmentProperties']
  end

  def render?
    !properties.nil?
  end

  def type
    attachment_properties['type']
  end

  def version
    attachment_properties['version']
  end

  def classname
    return nil unless attachment_properties.keys.include?('className')
    attachment_properties['className'].split('.')[-1]
  end

  def properties
    return nil unless attachment_properties.keys.include?('properties')
    attachment_properties['properties']
  end

  def entries
    return [] if properties.nil?
    entry = properties['entry']
    arry = (entry.kind_of? Hash) ? [entry] : entry
  end

  private
  attr_reader :channel, :attachment_properties

end
