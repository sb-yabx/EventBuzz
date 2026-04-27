class ActivityOwnerController < ApplicationController
  include BeforeAction

    before_action :authenticate_user!
    before_action :is_activity_owner

  def index
  activities = Activity.where(user_id: params[:id]).includes(:event)
  @event = Event.find_by(id: params[:event_id])

  @upcoming_activities = activities
                          .where('events.date >= ?', Date.today)
                          .joins(:event)
                          .order(:date)

  @past_activities = activities
                      .where('events.date < ?', Date.today)
                      .joins(:event)
                      .order(date: :desc)
end
end
