class GuestsController < ApplicationController
  include BeforeAction

  before_action :authenticate_user!
  before_action :is_guest

  def index
  base = Event
           .joins(:rsvps)
           .where(rsvps: { user_id: current_user.id })
           .includes(:venue)

  @upcoming_events = base
                       .where('start_date >= ?', Date.today)
                       .paginate(page: params[:page], per_page: 4)

  @past_events = base
                  .where('start_date < ?', Date.today)
                  .paginate(page: params[:page], per_page: 2)
end

  def events
     @events = Event.joins(:rsvps).where(rsvps: { user_id: current_user.id }).order(Arel.sql('start_date < current_date, start_date ASC'))
     .includes(:venue).paginate(page: params[:page], per_page: 3)
  end

  def queries
    @events = Event
            .joins(:queries)
            .where(queries: { user_id: current_user.id })
            .order(start_date: :desc)
            .distinct
            .paginate(page: params[:page], per_page: 1)
  end
end
