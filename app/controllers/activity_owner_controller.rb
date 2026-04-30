class ActivityOwnerController < ApplicationController
  include BeforeAction

    before_action :authenticate_user!
    before_action :is_activity_owner

  def index
  activities = Activity.where(user_id: current_user.id).includes(:event)
  @event = Event.find_by(id: params[:event_id])

  @upcoming_activities = activities
                          .where('events.start_date >= ?', Date.today)
                          .joins(:event)
                          .order(:start_date)

  @past_activities = activities
                      .where('events.start_date < ?', Date.today)
                      .joins(:event)
                      .order(start_date: :desc)
  end
end
