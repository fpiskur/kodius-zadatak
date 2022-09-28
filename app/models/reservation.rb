class Reservation < ApplicationRecord

  belongs_to :room
  belongs_to :user

  validates :room_id, :user_id, presence: :true
  VALID_DATE_REGEX = /\d{4}\-\d{2}\-\d{2}/
  validates :check_in_at, :check_out_at, presence: true,
                                         format: { with: VALID_DATE_REGEX }
  validates :check_out_at, comparison: { greater_than: :check_in_at }
  validates :check_in_at, comparison: { greater_than_or_equal_to: Date.today,
                          message: "- Check in date cannot be in the past" }

  validate :reservation_available

  private

    def reservation_available
      # Get any overlaps
      sql = ":check_out_at >= check_in_at AND check_out_at > :check_in_at"
      reservations = room.reservations.where(sql,
              check_out_at: check_out_at, check_in_at: check_in_at)
      return if reservations.none?
      errors.add(:base, "Those dates are not available for reservation")
    end
  
end
