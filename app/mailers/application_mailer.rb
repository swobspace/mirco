# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: -> { Mirco.mail_from }, to: ->{ Mirco.mail_to }
  layout 'mailer'
end
