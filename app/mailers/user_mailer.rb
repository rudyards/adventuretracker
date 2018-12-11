class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
def password_reset(user)
    @user = user
    @host = Rails.env.development? ? 'http://localhost:3000' : 'http://adventuretracker.herokuapp.com'
    mail to: user.email, subject: "Password reset"
  end
end
