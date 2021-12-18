# Preview all emails at http://localhost:3000/rails/mailers/notification
class NotificationPreview < ActionMailer::Preview

  def alert
    NotificationMailer.with(
      alert: Alert.first,
      message: "Just a dummy message"
    ).alert
  end

end
