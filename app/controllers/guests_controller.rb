class GuestsController < ApplicationController
  include CommonMethods

  before_action :authenticate_user!
  before_action :is_guest

  def index
    @events = Event.joins(:rsvps).where(rsvps: { user_id: current_user.id })
    @upcoming_events = @events.where("date >= ?", Date.today)
    @past_events = @events.where("date < ?", Date.today)
  end

  def events
     @events = Event.joins(:rsvps).where(rsvps: { user_id: current_user.id }).order(Arel.sql("date < current_date, date ASC"))
  end

  def queries
    @events = Event.where(id: Query.where(user_id: current_user.id).select(:event_id)).order(date: :desc)
  end
end
