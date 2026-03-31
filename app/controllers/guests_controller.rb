class GuestsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_guest
  def index
    @events = Event.joins(:rsvps).where(rsvps: {user_id: current_user.id}).order(Arel.sql("date < current_date, date ASC"))
  end

  def events
     @events = Event.joins(:rsvps).where(rsvps: {user_id: current_user.id}).order(Arel.sql("date < current_date, date ASC"))
  
  end

  private
  def only_guest
  allowed_roles = ["event_manager", "activity_owner", "admin"]

  return unless allowed_roles.include?(current_user&.role)
  redirect_to root_path, alert: "Only guests allowed"

end
 

end
