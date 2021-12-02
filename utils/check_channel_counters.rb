#!/usr/bin/env ruby
ENV['RAILS_ENV'] ||= 'development'
require File.dirname(__FILE__) + '/../config/environment.rb'

ChannelCounter.all.each do |cc|
  cs = ChannelStatistic.where(id: cc.channel_statistic_id).first
  if cs.nil?
    puts "ERROR:: counter #{cc.id} has no channel statistic"
  elsif (cc.server_id == cs.server_id) &&
        (cc.channel_id == cs.channel_id) &&
        (cc.meta_data_id == cs.meta_data_id)
  else
    puts "ERROR:: counter #{cc.id} mismatch with channel #{cs.id}"
  end
end
