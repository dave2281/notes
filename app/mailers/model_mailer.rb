class ModelMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.notifications.subject
  #
  def notifications
    @greeting = "Hi"

    mail to: current_user.email
  end
end
