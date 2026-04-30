class GuestsController < ApplicationController
  include BeforeAction

  before_action :authenticate_user!
  before_action :is_guest

  def index
    @events = Event.joins(:rsvps).where(rsvps: { user_id: current_user.id })
    @upcoming_events = @events.where('start_date >= ?', Date.today)
    @past_events = @events.where('start_date < ?', Date.today)
  end

  def events
     @events = Event.joins(:rsvps).where(rsvps: { user_id: current_user.id }).order(Arel.sql('start_date < current_date, start_date ASC'))
     .includes(:venue)
  end

  def queries
    @events = Event.where(id: Query.where(user_id: current_user.id).select(:event_id)).order(start_date: :desc)
  end
end
