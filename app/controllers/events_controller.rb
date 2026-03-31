
class EventsController < ApplicationController
    before_action :authenticate_user!
    before_action :is_event_manager , except: [:show, :index]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path, notice: "Created Successfully"
    else
      render :new, alert: "Try again"
    end
  end

  def index
    @events = Event.all.order(Arel.sql("date < current_date, date ASC"))
  end

  def show
    @event = Event.find(params[:id])
    @activities = Activity.where(event_id:@event)
  end

  def edit
    @event =  Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Event updated successfully!"
    else
      render :edit, alert: "Error. Try again"
    end
  end


  # email invite to guests

  def invite_guests
    @event = Event.find(params[:event_id])
  end

  def send_invites
  @event = Event.find(params[:id])

  if params[:emails].present? && params[:excel_file].present?
  redirect_to request.referer, alert: "Please use only one option: Email or Excel" and return
  end

  if params[:emails].blank? && params[:excel_file].blank?
    redirect_to request.referer, alert: "Please provide emails or upload Excel file" and return
  end

  emails = []

  # mannual email
  if params[:emails].present?
    emails = params[:emails].split(",").map(&:strip)
  end

  # excel
  if params[:excel_file].present?
    sheet = Roo::Spreadsheet.open(params[:excel_file].path)

    header = sheet.row(1)
    email_index = header.index("email")

    if email_index.nil?
      redirect_to request.referer, alert: "Excel must have 'email' column" and return
    end

    (2..sheet.last_row).each do |i|
      email = sheet.row(i)[email_index]
      emails << email if email.present?
    end
  end

  # Remove duplicates
  emails = emails.map(&:downcase).uniq

  emails.each do |email|

    # Avoid duplicate guest
    guest = Guest.find_or_create_by(email: email, event_id: @event.id)

    user = User.find_by(email: email)

    if user
      Rsvp.find_or_create_by(
        user_id: user.id,
        event_id: @event.id
      ) do |r|
        r.status = "pending"
      end
    end

    # Send email
    GuestMailer.invite_email(email.strip, @event).deliver_later
  end

  redirect_to rsvp_invites_path(@event), notice: "Invitations sent!"
end



  private
  def event_params
    params.require(:event).permit(:name, 
    :description, 
    :date, 
    :start_time, 
    :end_time, 
    :event_manager_id, 
    :venue_id)
  end

  def is_event_manager
    allowed = ["event_manager", "admin"]
    unless allowed.include?(current_user&.role)
    redirect_to root_path, alert: "Access denied"
    end
  end



end
