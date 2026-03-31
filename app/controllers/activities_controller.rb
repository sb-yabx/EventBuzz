class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_owner

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
      flash[:notice] = "Event created successfully!"   # ✅ redirect → flash
      redirect_to event_path(@event)
    else
      flash.now[:alert] = "Try again"                  # ✅ render → flash.now
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
      flash[:notice] = "Activity updated successfully!"   # ✅ redirect → flash
      redirect_to event_path(@event)
    else
      flash.now[:alert] = "Error in update. Try again"    # ✅ render → flash.now
      render :edit, status: :unprocessable_entity
    end
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

  def is_owner
    allowed_roles = ["event_manager", "admin", "activity_owner"]

    unless allowed_roles.include?(current_user&.role)
      flash[:alert] = "Access denied"   # ✅ redirect case → flash
      redirect_to root_path
    end
  end
end