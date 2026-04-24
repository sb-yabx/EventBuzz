class ActivitiesController < ApplicationController
  include CommonMethods

  before_action :authenticate_user!
  before_action :is_valid_manager

  def index
  end

  def show
    @event = Event.find(params[:event_id])
    @activity = @event.activities.find(params[:id])
  end

  def new
    @event = Event.find(params[:event_id])
    @activity = @event.activities.new
  end

  def create
    @event = Event.find(params[:event_id])
    @activity = @event.activities.new(activity_params)

    if @activity.save
      flash[:notice] = "Event created successfully!"
      redirect_to event_path(@event)
    else
      flash.now[:alert] = "Try again"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @activity = @event.activities.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @activity = @event.activities.find(params[:id])

    if @activity.update(activity_params)
      flash[:notice] = "Activity updated successfully!"
      redirect_to event_path(@event)
    else
      flash.now[:alert] = "Error in update. Try again"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @activity = @event.activities.find(params[:id])
    @activity.destroy

    flash[:notice] = "Activity deleted successfully!"
    redirect_to event_path(@event)
  end


  private

  def activity_params
    params.require(:activity).permit(
      :activity_name,
      :activity_description,
      :start_time,
      :end_time,
      :user_id
    )
  end
end
