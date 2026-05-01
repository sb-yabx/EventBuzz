class ActivityOwnerController < ApplicationController
  include BeforeAction

    before_action :authenticate_user!
    before_action :is_activity_owner

  def index
  activities = Activity.where(user_id: current_user.id)
  .joins(:event)
  .includes(:event)
  .order('event.start_date ASC')

  @event = Event.find_by(id: params[:event_id])

  @upcoming_activities = activities.where('event.start_date >= ?', Date.today).paginate(page: params[:page], per_page: 2)

  @past_activities = activities.where('event.start_date < ?', Date.today).paginate(page: params[:page], per_page: 2)
  end
end
