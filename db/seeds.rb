# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


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
