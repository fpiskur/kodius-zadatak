class Image < ApplicationRecord

  belongs_to :room

  validates :url, :room_id, presence: true

end
