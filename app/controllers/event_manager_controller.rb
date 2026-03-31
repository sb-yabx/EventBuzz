class EventManagerController < ApplicationController
    before_action :authenticate_user!
    before_action :is_owner

  def index
    @events = Event.where(event_manager_id: params[:id]).order(Arel.sql("date < current_date, date ASC"))
  end

  private
  def is_owner
    return if current_user&.role == "event_manager"
    redirect_to root_path , alert: "Only event manager allowed"
  end
end
