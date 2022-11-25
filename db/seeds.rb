require 'faker'
require "open-uri"
require "nokogiri"

User.destroy_all
Listing.destroy_all
Booking.destroy_all

# Nokogiri scraping
url = "https://rent4keeps.com.au/rental-product/gaming/"
titles = []
img_urls = []
html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search(".product img").each do |element|
  img_urls << element.attribute("src").value
end
img_urls.shift

html_doc.search(".product h2").each do |element|
  titles << element.text.strip
end
# Nokogiri end

users = []
emails = ["test@test.com", "test1@test.com"]
emails.each do |email|
  users << User.create!(email: email, password: "secret", first_name: "Random", last_name: "User")
end

puts "Start Seeding"
12.times do |i|
  listing = Listing.new(
    title: titles[i],
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    user: users[rand(users.size)],
    rental_price: (1..15).to_a.sample
  )
  file = URI.open(img_urls[i])
  listing.photos.attach(io: file, filename: "#{i}.jpg", content_type: "image/jpg")
  puts "#{i + 1} listing added." if listing.save
end
puts "Seed completed."
