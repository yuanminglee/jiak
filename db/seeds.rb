# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

puts 'creating 100 restaurants'
100.times do
  restaurant = Restaurant.new(
    name: Faker:: Company.name,
    description: Faker::Quote.famous_last_words,
    address: Faker::Address.street_name,
    collection_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    )
  restaurant.save!
end

puts "restos created!"

