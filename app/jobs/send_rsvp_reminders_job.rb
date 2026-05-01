class SendRsvpRemindersJob < ApplicationJob
  queue_as :default

 def perform
  target_dates = [ 3, 4, 5 ].map { |n| Date.current + n.days }
  Event.where(date: target_dates).find_each do |event|
    event.rsvps.pending.includes(:user).find_each do |rsvp|
      RsvpMailer.reminder_email(rsvp.user, event).deliver_later
    end
  end
end
end
