class RsvpMailer < ApplicationMailer
  def reminder_email(user, event)
    @user = user
    @event = event

     mail(
      to: @user.email,
      subject: "Reminder: Please RSVP for #{@event.name}"
    )
  end
end
