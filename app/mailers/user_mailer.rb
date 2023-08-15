# frozen_string_literal: true

# UserMailer is responsible for sending email notifications related to user actions and events.
# It inherits from ApplicationMailer, which provides the basic email sending functionality.
class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = User.find(user.id)
    # このurlでリダイレクトするとパスワードがリセットされる。
    @url = edit_password_reset_url(@user.reset_password_token)
    # toは宛先、subjectは件名を指定する。
    mail(to: user.email,
         subject: 'パスワードリセット')
  end
end
