# frozen_string_literal: true

class TdExpirationComponent < ViewComponent::Base
  def initialize(tstamp:, expiration_time:)
    @tstamp = tstamp
    @expiration_time = expiration_time
    @background_color = background_color
  end

  private
  attr_reader :tstamp, :expiration_time

  def background_color
    if tstamp <= expiration_time.before(Time.now)
      "bg-warning"
    else
      ""
    end
  end

end
