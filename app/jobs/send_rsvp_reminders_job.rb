class SendRsvpRemindersJob < ApplicationJob
  queue_as :default

  def perform
    Event.find_each do |event|
      days_left = (event.date.to_date - Date.current).to_i

      # Only for 5, 4, 3 days before
      next unless [ 5, 4, 3 ].include?(days_left)

      event.rsvps.where(status: "pending").each do |rsvp|
        RsvpMailer.reminder_email(rsvp.user, event).deliver_now
      end
    end
  end
end
