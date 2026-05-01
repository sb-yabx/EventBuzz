class QueryMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_query

  def create
    @message = @query.query_messages.new(
      message: params[:message],
      sender_type: determine_sender_type,
      user: current_user
    )
    if @message.save
      redirect_to event_query_path(@query.event, @query)
    else
      redirect_back fallback_location: root_path, alert: 'Message cannot be blank'
    end
  end

  private
  def set_and_authorize_query
    @query = Query.find(params[:query_id])
    is_owner = @query.user_id == current_user.id
    is_manager = @query.event.event_manager_id == current_user.id
    redirect_to root_path, alert: 'Access denied' unless is_owner || is_manager
  end
end
