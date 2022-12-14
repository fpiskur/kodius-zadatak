class Room < ApplicationRecord

  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations
  has_many :images

end
