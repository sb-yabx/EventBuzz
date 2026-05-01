class EventManagerController < ApplicationController
  include BeforeAction
    before_action :authenticate_user!
    before_action :is_event_manager

  def index
  @events = current_user.events.order(Arel.sql('start_date < current_date, start_date ASC'))
            .includes(:venue).paginate(page: params[:page], per_page: 3)
end

def queries
  @queries = Query.joins(:event)
                  .where(events: { event_manager_id: current_user.id })
                  .includes(:user, :event)
                  .order(created_at: :desc)
                  .paginate(page: params[:page], per_page: 4)
end
end
