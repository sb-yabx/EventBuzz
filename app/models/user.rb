class User < ApplicationRecord
  has_many :events
  has_many :events, foreign_key: "event_manager_id", dependent: :nullify
  has_many :activities
  has_many :rsvps
  has_many :queries
  after_create :link_guest_records
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: "admin", event_manager: "event_manager", activity_owner: "activity_owner", guest: "guest"}


  def link_guest_records
  guests = Guest.where(email: self.email)

  guests.each do |guest|
    guest.update(user_id: self.id)

    # Also create RSVP if not exists
    Rsvp.find_or_create_by(user_id: self.id, event_id: guest.event_id) do |r|
      r.status = "pending"
    end
  end
end


end
