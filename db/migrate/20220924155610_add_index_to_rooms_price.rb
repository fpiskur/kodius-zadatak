class AddIndexToRoomsPrice < ActiveRecord::Migration[7.0]
  def change
    add_index :rooms, :price_per_day
  end
end
