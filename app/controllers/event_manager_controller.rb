class EventManagerController < ApplicationController
  include CommonMethods
    before_action :authenticate_user!
    before_action :is_event_manager

  def index
    @events = Event.where(event_manager_id: params[:id]).order(Arel.sql("date < current_date, date ASC"))
  end

def queries
  @queries = Query.joins(:event)
                  .where(events: { event_manager_id: current_user.id })
                  .includes(:user, :event)
                  .order(created_at: :desc)
end

end
