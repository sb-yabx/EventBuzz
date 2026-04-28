class EmployeeMailer < ApplicationMailer
  default from: 'noreply@eventbuzz.com'

  def welcome_email
    @user = params[:user]
    @token = params[:token]

    @reset_link = edit_user_password_url(reset_password_token: @token)

    mail(to: @user.email, subject: "Welcome to EventBuzz! Set your password")
  end
end
