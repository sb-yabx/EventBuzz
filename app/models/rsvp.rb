class Rsvp < ApplicationRecord
  belongs_to :user
  belongs_to :event


  validates :user_id, uniqueness: {scope: :event_id}

  # STATUS
  enum :status, {
    attending: "Attending",
    declined: "Not Attending",
    pending: "Pending"
  }

  # DIET
  enum :dietary_preference, {
    veg: "Veg",
    non_veg: "Non-Veg"
  }

  # SEATING
  enum :seating_preference, {
    window: "Window",
    front: "Front",
    back: "Back"
  }
end
