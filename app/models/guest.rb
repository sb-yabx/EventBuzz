class Guest < ApplicationRecord
  belongs_to :event, counter_cache: true
  belongs_to :user, optional: true
  has_many :rsvps, through: :user
end
