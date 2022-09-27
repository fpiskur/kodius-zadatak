class Reservation < ApplicationRecord

  belongs_to :room
  belongs_to :user

  validates :room_id, :user_id, presence: :true
  validates :check_in_at, :check_out_at, presence: true
  validates :check_out_at, comparison: { greater_than: :check_in_at }
  
end
