# frozen_string_literal: true

class TdExpirationComponent < ViewComponent::Base
  def initialize(tstamp:, expiration_time:, cssclass: 'text-center', manual_update: false)
    @tstamp = tstamp
    @expiration_time = expiration_time
    @background_color = background_color
    @cssclass = cssclass
    @manual_update = manual_update
  end

  private

  attr_reader :tstamp, :expiration_time, :cssclass, :manual_update

  def background_color
    if tstamp.nil? || (tstamp <= expiration_time.before(Time.current))
      manual_update ? 'bg-light' : 'bg-warning'
    else
      ''
    end
  end
end
