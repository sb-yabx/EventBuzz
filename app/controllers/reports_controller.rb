class ReportsController < ApplicationController

  def index
  end

  def event_reports
    @events = Event.includes(:venue, :guests).all.order(Arel.sql("date >= CURRENT_DATE DESC, date ASC"))
    @upcoming_events = Event.where("date >= ?", Date.today).order(:date)
    @completed_events = Event.where("date < ?", Date.today).order(:date)

  end

  def rsvp_statistics
  @upcoming_events = Event.where("date >= ?", Date.today).order(:date)
  @completed_events = Event.where("date < ?", Date.today).order(:date)
  @total_invited = Guest.count
  @accepted = Rsvp.where(status: "attending").count
  @declined = Rsvp.where(status: "declined").count
  @pending = Rsvp.where(status: "pending").count

  total = @total_invited

  @response_rate = total > 0 ? ((@accepted + @declined) * 100 / total) : 0

  @accepted_percent = total > 0 ? (@accepted * 100 / total) : 0
  @declined_percent = total > 0 ? (@declined * 100 / total) : 0
  @pending_percent  = total > 0 ? (@pending * 100 / total) : 0
  end

  def guest_preferences
    @upcoming_events = Event.where("date >= ?", Date.today).order(:date)
    @completed_events = Event.where("date < ?", Date.today).order(:date)
  end

  def venue_utilization
    @venues = Venue.includes(:events).all
  end

end
