class Event < ApplicationRecord
  belongs_to :event_manager, class_name: "User", optional: true
  belongs_to :venue
  has_many :activities, dependent: :destroy
  has_many :guests
  has_many :rsvps

  validate :capacity_cannot_exceed_venue_capacity

  def capacity_cannot_exceed_venue_capacity
  return if capacity.blank? || venue.blank?

  if capacity > venue.capacity
    errors.add(:capacity, "cannot exceed venue capacity (#{venue.capacity})")
  end
  end

end
