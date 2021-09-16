# frozen_string_literal: true

class TdExpirationComponent < ViewComponent::Base
  def initialize(tstamp:, expiration_time:, cssclass: 'text-center')
    @tstamp = tstamp
    @expiration_time = expiration_time
    @background_color = background_color
    @cssclass = cssclass
  end

  private
  attr_reader :tstamp, :expiration_time, :cssclass

  def background_color
    if tstamp.nil? || (tstamp <= expiration_time.before(Time.now))
      "bg-warning"
    else
      ""
    end
  end

end
