class Admin::EmployeeController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def new
    @user = User.new
  end

  def create
    password = Devise.friendly_token.first(8)
    @user = User.new(user_params)
    @user.password = password
    @user.password_confirmation = password

    if @user.save
      EmployeeMailer.with(user: @user, password: password).welcome_email.deliver_later
      redirect_to admin_dashboard_path, notice: "Employee created successfully. Temporary password: #{password}"
    else
      render :new, alert: "Error creating employee: #{@user.errors.full_messages.join(", ")}"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :role)
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end


end
