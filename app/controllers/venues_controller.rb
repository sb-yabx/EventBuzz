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

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    @venue = Venue.find(params[:id])
    if @venue.update(venue_params)
      redirect_to @venue, notice: 'Venue was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @venue = Venue.find(params[:id])
    if @venue.destroy
      redirect_to venues_path , notice: 'Venue delete succesfully'
    else
     redirect_to venues_path, alert: "Try again!"
    end

  end





  private

  def venue_params
    params.require(:venue).permit(:name, :address, :capacity,:facilities, :contact)
  end


  def require_admin
    unless current_user.role == "admin" || current_user.role == "event_manager"
      redirect_to root_path, alert: "Access denied"
    end
  end


end
