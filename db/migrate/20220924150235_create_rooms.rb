class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.integer :number
      t.text :name
      t.integer :price_per_day
      t.text :description

      t.timestamps
    end
  end
end
