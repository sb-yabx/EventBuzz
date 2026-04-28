class QueriesController < ApplicationController
  include BeforeAction
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_query, only: [ :show ]
  before_action :is_guest, only: [ :new, :create ]
  before_action :only_authorized,  only: [ :show ]

  def index
    if current_user.role == 'event_manager'
      @queries = @event.queries.all
    end
    if current_user.role == 'guest'
      @queries = @event.queries.where(user: current_user)
    end
  end

  def new
   @event = Event.find(params[:event_id])
   @existing_query = @event.queries.find_by(user: current_user)
   if @existing_query
      redirect_to event_query_path(@event, @existing_query), notice: 'Start Chatting.'
   else
      @query = @event.queries.new
   end
    end


  def create
    @query = @event.queries.find_or_create_by(user: current_user)

    message_text = params[:query][:message]

  if message_text.present?
    @query.query_messages.create!(
      message: message_text,
      sender_type: 'user',
      user: current_user
    )
  end

  redirect_to event_query_path(@event, @query), notice: 'Chat started!'
  end


  def show
  @query = Query.find(params[:id])
  @messages = @query.query_messages.includes(:user)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_query
    @query = @event.queries.find(params[:id])
  end


  def only_authorized
    @query = @event.queries.find_by(id: params[:id])
    return redirect_to root_path, alert: 'Not found' unless @query
    return if current_user.admin? || @event.event_manager_id == current_user.id
    redirect_to root_path, alert: 'Access denied' unless @query.user_id == current_user.id
  end
end
