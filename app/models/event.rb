class Event < ApplicationRecord
  belongs_to :event_manager, class_name: "User", optional: true
  belongs_to :venue
  has_many :activities, dependent: :destroy
  has_many :guests
  has_many :rsvps
end
