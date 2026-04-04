class Guest < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true
   has_many :rsvps, through: :user
end
