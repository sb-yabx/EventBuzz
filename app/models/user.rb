class User < ApplicationRecord
  has_many :events, foreign_key: 'event_manager_id', dependent: :nullify
  has_many :activities
  has_many :rsvps
  has_many :queries
  after_create :link_guest_records

  validates :name, presence: true
  validates :role, presence: true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable, :timeoutable

  enum :role, { admin: 'admin', event_manager: 'event_manager', activity_owner: 'activity_owner', guest: 'guest' }


  def password_required?
  new_record? ? false : super
  end

  def link_guest_records
    return if Guest.where(email: email).empty?
    Guest.where(email: email).update_all(user_id: id)   # 1 UPDATE
    update_column(:role, 'guest') if role.blank?         # 1 UPDATE max
    Guest.where(email: email).pluck(:event_id).each do |event_id|
      Rsvp.find_or_create_by(user_id: id, event_id: event_id) { |r| r.status = :pending }
    end
  end
end
