# Helper methods

def get_sg_addresses(num_addresses)
  response = HTTParty.get("https://data.gov.sg/api/action/datastore_search?resource_id=482bfa14-2977-4035-9c61-c85f871daf4e&limit=#{num_addresses}")
  results = JSON.parse(response.body)
  addresses = results["result"]["records"].map do |result|
    result.select {|k,_| %w[blk_no street].include? k }.values.sort.join(" ") + " SINGAPORE"
  end
end

def generate_ingredients(num_ingredients)
  ingredients = Array.new(num_ingredients) { Faker::Food.ingredient }
  ingredients.map(&:downcase).join(", ")
end

def random_date_by_dow(start_date, end_date, dows)
  dow_nums = dows.map { |dow| Date::DAYNAMES.index(dow) }
  filtered_dates = (start_date..end_date).select { |date| dow_nums.include? date.wday }
  filtered_dates.sample
end

def attach_random_photo(record, search_term)
  return if record.photo.attached?

  search_term = "random" unless search_term.ascii_only?
  file = URI.open("https://source.unsplash.com/featured/800x600?#{search_term}")
  record.photo.attach(io: file, filename: "#{search_term}.jpg", content_type: 'image/jpg')
end

# Clean up
# Destroy orders
Order.destroy_all

# Destroy meals
Meal.destroy_all

# Destroy restaurants
Restaurant.destroy_all

# Destroy users
User.destroy_all

# Create 10 users (with photo upload)
puts "Seeding 10 users..."
10.times do
  puts "Creating user..."
  user = User.create!(
    name: Faker::TvShows::HowIMetYourMother.character,
    mobile_number: "+65#{8.times.map{rand(8)}.join}",
    description: Faker::TvShows::HowIMetYourMother.quote,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6)
  )
  puts "User created: #{user.name}. Attaching photo..."
  attach_random_photo(user, "person")
  puts "Photo attached"
end

# Create 10 chefs (with photo upload)
puts "Seeding 10 chefs..."
10.times do
  puts "Creating chef..."
  chef = User.create!(
    name: Faker::TvShows::HowIMetYourMother.character,
    mobile_number: "+65#{8.times.map{rand(8)}.join}",
    description: Faker::TvShows::HowIMetYourMother.quote,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6),
    is_chef: true
  )
  puts "Chef created: #{chef.name}. Attaching photo..."
  attach_random_photo(chef, "chef")
  puts "Photo attached"
end

# Create 10 restaurants (with photo upload)
puts "Seeding 10 restaurants"
addresses = get_sg_addresses(10)
addresses.each do |address|
  puts "Creating restaurant..."
  restaurant = Restaurant.create!(
    name: Faker::Restaurant.name,
    description: Faker::Restaurant.description,
    address: address,
    collection_time: Time.new(2021,1,1,rand(0..11),0,0),
    opening_days: Date::DAYNAMES.sample(3),
    user: User.where(is_chef: true).sample
  )
  puts "Restaurant created: #{restaurant.name}. Attaching photo..."
  attach_random_photo(restaurant, "restaurant,#{restaurant.name}")
  puts "Photo attached"
end

# Create 10 meals per restaurant (with photo upload)
puts "Seeding 10 meals per restaurant..."
Restaurant.all.each do |restaurant|
  10.times do
    puts "Creating meal..."
    restaurant.meals.build({
      name: Faker::Food.dish,
      description: Faker::Food.description,
      ingredients: generate_ingredients(8),
      price: rand(5.0..20.0),
      pax: rand(1..5)
    })
    restaurant.save!
    puts "Meal created: #{restaurant.meals.last.name}"
  end

  restaurant.meals.each do |meal|
    puts "Attaching photo to #{meal.name}..."
    attach_random_photo(meal, "#{meal.name},plate")
    puts "Photo attached"
  end
end

# Create 5 orders per restaurant
puts "Seeding 5 orders per restaurant..."
Restaurant.all.each do |restaurant|
  5.times do
    puts "Creating order..."
    restaurant.orders.build({
      collection_date: random_date_by_dow(Date.today, Date.today + 1.month, restaurant.opening_days),
      notes: Faker::Quote.famous_last_words,
      status: %w[Draft Confirmed Cancelled].sample,
      user: User.where(is_chef: false).sample
    })
    restaurant.save!
    puts "Order created: ##{restaurant.orders.last.id}"
    puts "Adding meals to order..."

    restaurant.orders.each do |order|
      restaurant.meals.count.times do
        order.line_items.build({
          quantity: rand(1..10),
          meal: restaurant.meals.sample
        })
      end

      order.save!
      puts "Meal added to order."
    end

    restaurant.save!
  end
end
