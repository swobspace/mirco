class ServerDecorator < Draper::Decorator
  delegate_all

  def last_channel_update
    object.last_channel_update.localtime.to_formatted_s(:db) unless object.last_channel_update.nil?
  end

  def last_check
    object.last_check.localtime.to_formatted_s(:db) unless object.last_check.nil?
  end

  def last_check_ok
    object.last_check_ok.localtime.to_formatted_s(:db) unless object.last_check_ok.nil?
  end
end
