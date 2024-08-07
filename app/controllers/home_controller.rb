# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @queued_messages = ChannelStatistic.active.current.queued.order('queued desc')
    @servers = Server.failed.order(:name).where(manual_update: false)
    @problems = ChannelStatistic.active.current.escalated.order('condition desc')
    @problems = @problems - @queued_messages
  end
end
