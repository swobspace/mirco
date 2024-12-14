class SearchesController < ApplicationController
  def index
    @results = (servers + channels + channel_statistics)
    if @results.count > 20
      @results = @results.first(20)
      @info = I18n.t('mirco.to_much_results')
    end
  end

private

  def servers
    Server.where('name ILIKE ?', query)
  end

  def channels
    Channel.where("properties ->> 'name' ILIKE ?", query)
  end

  def channel_statistics
    ChannelStatistic.where('name ILIKE ?', query)
  end

  def query
    "%#{searchstring}%"
  end

  def searchstring
    params[:query]&.strip
  end
end
