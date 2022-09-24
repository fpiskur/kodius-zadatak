class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :check_in_at
      t.date :check_out_at

      t.timestamps
    end
    add_index :reservations, :check_in_at
    add_index :reservations, :check_out_at
    add_index :reservations, [:check_in_at, :check_out_at]
  end
end
