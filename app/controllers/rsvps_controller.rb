class RsvpsController < ApplicationController
  include CommonMethods
  before_action :authenticate_user!
  before_action :is_valid_manager, except: [ :new, :create ]
  before_action :is_event_manager, only: [ :dashboard ]

  def index
    @event = Event.find(params[:event_id])
    @rsvps = @event.rsvps.includes(:user)


    # status
    if params[:status].present?
      @rsvps = @rsvps.where(status: Rsvp.statuses[params[:status]])
    end

    # parking
    if params[:parking].present?
      @rsvps = @rsvps.where(need_parking: params[:parking] == "true")
    end

    # accommodation
    if params[:accommodation].present?
      @rsvps = @rsvps.where(need_accommodation: params[:accommodation] == "true")
    end

    # diet
    if params[:diet].present?
      @rsvps = @rsvps.where(dietary_preference: Rsvp.dietary_preferences[params[:diet]])
    end
  end


  def new
    @event = Event.find(params[:event_id])
    guest = Guest.find_by(email: current_user.email, event: @event)

    unless guest
      redirect_to root_path, alert: "You are not invited"
    end

    guest.update(user_id: current_user.id) if guest

    @rsvp = Rsvp.new
  end

  def create
    @event = Event.find(params[:event_id])

    @rsvp = @event.rsvps.find_or_initialize_by(user_id: current_user.id)
    @rsvp.assign_attributes(rsvp_params)

    if @rsvp.save
      redirect_to @event, notice: "RSVP submitted. Thank You"
    else
      flash.now[:alert] =  "Error Occured. Try again"
      render :new
    end
  end

  # dashboard for event manager to see all the rsvps for their events
  def dashboard
    @events = Event.where(event_manager_id: params[:id])
    @upcoming_events = @events.where("date >= ?", Date.today)
    @past_events = @events.where("date < ?", Date.today)
  end

  # special requests for the event

  def special_requests
    @event = Event.find(params[:event_id])
    @rsvps = @event.rsvps.where.not(special_request: [ nil, "" ])
  end

  # show all the invited guests for the event
  def invitesSend
    @event = Event.find(params[:id])
    @guests = @event.guests.all
  end


  # download rsvp report pdf
  def download_pdf
  @event = Event.find(params[:event_id])

  @rsvps = @event.rsvps.includes(:user)

  if params[:status].present?
    @rsvps = @rsvps.where(status: params[:status])
  end

  if params[:parking].present?
    @rsvps = @rsvps.where(need_parking: params[:parking] == "true")
  end

  if params[:accommodation].present?
    @rsvps = @rsvps.where(need_accommodation: params[:accommodation] == "true")
  end

  if params[:diet].present?
    @rsvps = @rsvps.where(dietary_preference: params[:diet])
  end

  pdf = Prawn::Document.new

  pdf.text "RSVP Report - #{@event.name}", size: 18, style: :bold
  pdf.move_down 10
  pdf.text "Date: #{@event.date.strftime("%B %d, %Y")}"
  pdf.move_down 20

  table_data = [ [ "S.No.", "Name", "Email", "Status", "Diet", "Seating", "Parking", "Accommodation" ] ]

  @rsvps.each_with_index do |rsvp, index|
    table_data << [
      index+1,
      rsvp.user&.name || "Guest",
      rsvp.user&.email,
      rsvp.status,
      rsvp.dietary_preference,
      rsvp.seating_preference,
      rsvp.need_parking ? "Yes" : "No",
      rsvp.need_accommodation ? "Yes" : "No"
    ]
  end

  pdf.table(table_data, header: true)

  send_data pdf.render,
            filename: "rsvp_report.pdf",
            type: "application/pdf",
            disposition: "attachment"
end


# downlaod special request pdf
def download_pdf_special_requests
  @event = Event.find(params[:event_id])
  @rsvps = @event.rsvps.where.not(special_request: [ nil, "" ])
  pdf = Prawn::Document.new
  pdf.text "Special Requests Report - #{@event.name}", size: 18, style: :bold
  pdf.move_down 10
  pdf.text "Date: #{@event.date.strftime("%B %d, %Y")}"
  pdf.move_down 20
  table_data = [ [ "S.No.", "Name", "Email", "Special Request" ] ]
  @rsvps.each_with_index do |rsvp, index|
    table_data << [
      index+1,
      rsvp.user&.name || "Guest",
      rsvp.user&.email,
      rsvp.special_request
    ]
  end
  pdf.table(table_data, header: true)
  send_data pdf.render,
            filename: "special_requests_report.pdf",
            type: "application/pdf",
            disposition: "attachment"
end



  private
  def rsvp_params
    params.require(:rsvp).permit(:status,
    :special_request,
    :dietary_preference,
    :seating_preference,
    :need_parking,
    :need_accommodation)
  end
end
