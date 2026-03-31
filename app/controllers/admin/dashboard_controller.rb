class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  def index
    # This action will render app/views/admin/dashboard/index.html.erb by default
    @users = User.where(role: [:event_manager, :activity_owner])
    @venues = Venue.all 
  end


  private 
  def require_admin
    unless current_user&.admin?
      redirect_back fallback_location: root_path, alert: "Access denied"
    end
  end

end