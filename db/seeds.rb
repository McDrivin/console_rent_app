# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"

emails = ["test@test.com", "test1@test.com"]

puts "Start Seeding"
emails.each do |email|
  user = User.create!(email: email, password: "secret")
  12.times do |i|
    listing = Listing.new(
      title: Faker::Game.platform,
      description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      user: user,
      rental_price: (1..15).to_a.sample
    )
    file = URI.open("https://source.unsplash.com/random/500x500?gaming-console")
    listing.photos.attach(io: file, filename: "#{i}.jpg", content_type: "image/jpg")
    puts "#{i + 1} listing added." if listing.save
  end
end
puts "Seed completed."
