class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @users = User.where(role: [ :event_manager, :activity_owner ])
    @venues = Venue.all
    @events = Event.all
    @activities = Activity.all
    @rsvps = Rsvp.all
  end

  def all_users
    @users = User.where(role: [ :event_manager, :activity_owner ])
  end


  private
  def require_admin
    unless current_user&.role == 'admin'
      redirect_back fallback_location: root_path, alert: 'Access denied'
    end
  end
end
