class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.text :password_digest
      t.text :remember_digest
      t.boolean :admin, default: false
      t.text :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.text :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
