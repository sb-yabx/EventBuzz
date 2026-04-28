class EventMailer < ApplicationMailer
  default from: ENV.fetch('MAILER_FROM', 'noreply@eventbuzz.com')
  # default from: 'sneha040222@gmail.com'

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
