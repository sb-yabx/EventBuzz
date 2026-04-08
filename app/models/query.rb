class Query < ApplicationRecord
  has_many :query_messages, dependent: :destroy
  belongs_to :event
  belongs_to :user
end

