# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts "Seeding started"
puts "Deleting cocktails"
Cocktail.destroy_all
puts "Deleting doses"
Dose.destroy_all
puts "Deleting ingredients"
Ingredient.destroy_all

doses = ["50 ml", "75 ml", "100 ml", "150 ml", "175 ml", "225 ml", "250 ml"]

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

file = open(url).read
list = JSON.parse(file)

list["drinks"].each do |ing|
  ingredient = ing["strIngredient1"]
  Ingredient.create(name: ingredient)
end

21.times do
  puts "Starting created!"
  name = Faker::Beer.hop
  cocktail = Cocktail.create(name: name)
  url = "https://source.unsplash.com/random?cocktail"
  puts "Waiting for unsplash to refresh search"
  sleep(3)
  cocktail.remote_photo_url = url
  cocktail.save

  3.times do
    rand_ingredient = Ingredient.all.sample
    dose_description = doses.sample
    dose = Dose.new( description: dose_description)
    dose.ingredient = rand_ingredient
    dose.cocktail = cocktail
    dose.save
  end
  puts "Drink created!"
end

puts "Seeding finished!"
puts "#{Ingredient.all.count} ingredients added."
puts "#{Dose.all.count} doses added."
puts "#{Cocktail.all.count} drinks added."
