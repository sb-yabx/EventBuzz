class EmployeeMailer < ApplicationMailer
  default from: "noreply@eventbuzz.com"

  def welcome_email
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: "Welcome to EventBuzz!")
  end
end
