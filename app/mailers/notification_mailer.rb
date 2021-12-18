class NotificationMailer < ApplicationMailer

  def alert
    @alert = params[:alert]
    @alertable = @alert.alertable
    @message   = params[:message] || @alert.message
    @subject    = "#{@alert.type.capitalize} for #{@alertable.fullname}"

    mail(subject: @subject)
  end
end
