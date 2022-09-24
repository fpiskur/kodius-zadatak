# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create users
User.create!(
  name: "Admin User",
  email: "filip.piskur@gmail.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

User.create!(
  name: "Other User",
  email: "info@info.info",
  password: "password",
  password_confirmation: "password",
  activated: true,
  activated_at: Time.zone.now
)

# Create rooms
1.upto(5) do |n|
  1.upto(5) do |m|
    number = (n.to_s + m.to_s).to_i
    name = Faker::Mountain.unique.name
    price_per_day = Faker::Number.number(digits: 2)
    description = Faker::Lorem.paragraph(sentence_count: 4)
    Room.create!( number: number,
                  name: name,
                  price_per_day: price_per_day,
                  description: description)
  end
end

# Create reservations
Reservation.create!(room_id: 1,
                    user_id: 2,
                    check_in_at: Date.today.to_fs,
                    check_out_at: (Date.today + 5).to_fs)

Reservation.create!(room_id: 6,
                    user_id: 2,
                    check_in_at: Date.yesterday.to_fs,
                    check_out_at: Date.today.to_fs)

Reservation.create!(room_id: 12,
                    user_id: 2,
                    check_in_at: (Date.today + 8).to_fs,
                    check_out_at: (Date.today + 13).to_fs)
