class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @event_managers = User.where(role: :event_manager).count
    @activity_owners = User.where(role: :activity_owner).count
    @venues = Venue.count
    @events = Event.count
    @activities = Activity.count
    @rsvps = Rsvp.count
  end

  def all_users
    @users = User.where(role: [ :event_manager, :activity_owner ])
    .paginate(page: params[:page], per_page: 2)
  end


  private
  def require_admin
    unless current_user&.role == 'admin'
      redirect_back fallback_location: root_path, alert: 'Access denied'
    end
  end
end
