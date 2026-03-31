class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin 

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.create(venue_params)
    if @venue.save
      redirect_to root_path
    else
      render :new
    end

  end

  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
    @events = Event.where(venue_id: @venue)
  end



  private

  def venue_params
    params.require(:venue).permit(:name, :address, :capacity)
  end


  def require_admin
    unless current_user.role == "admin" || current_user.role == "event_manager"
      redirect_to root_path, alert: "Access denied"
    end
  end


end
