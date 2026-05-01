class Guest < ApplicationRecord
  belongs_to :event, counter_cache: true
  belongs_to :user, optional: true
  has_many :rsvps, through: :user
  validates :email, presence: true

  before_validation { self.email = email.to_s.strip.downcase }
end
