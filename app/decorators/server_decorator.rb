# frozen_string_literal: true

class ServerDecorator < Draper::Decorator
  delegate_all

  def last_channel_update
    object.last_channel_update&.localtime&.to_fs(:local)
  end

  def last_check
    object.last_check&.localtime&.to_fs(:local)
  end

  def last_check_ok
    object.last_check_ok&.localtime&.to_fs(:local)
  end
end
