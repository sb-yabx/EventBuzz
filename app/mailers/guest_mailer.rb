class GuestMailer < ApplicationMailer
  def invite_email(email, event)
    @event = event
    @url = new_event_rsvp_url(@event)

    mail(to: email, subject: "You're invited to #{@event.name}")
  end
end
