class EventMailer < ApplicationMailer
  default from: 'sneha040222@gmail.com'

  def custom_email(guest, subject, message, event)
    @guest = guest
    @event = event
    @message = message

    mail(
      to: @guest.email,
      subject: subject
    )
  end
end
