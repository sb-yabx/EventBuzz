class QueryMessage < ApplicationRecord
  belongs_to :query
  belongs_to :user, optional: true
  validates :message, presence: true

  enum :sender_type, { user: "user", admin: "admin" }
end
