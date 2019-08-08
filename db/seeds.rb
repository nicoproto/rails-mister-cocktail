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
puts "Cleaning ingredients list"
Cocktail.destroy_all
Dose.destroy_all
Ingredient.destroy_all

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

file = open(url).read
list = JSON.parse(file)

list["drinks"].each do |ing|
  ingredient = ing["strIngredient1"]
  Ingredient.create(name: ingredient)
end

puts "Seeding finished, #{list["drinks"].count} ingredients added."

10.times do
  name = Faker::Beer.hop
  cocktail = Cocktail.create(name: name)

  3.times do
    rand_ingredient = Ingredient.all.sample
    dose = Dose.new( description: "20kg")
    dose.ingredient = rand_ingredient
    dose.cocktail = cocktail
    dose.save
  end
end
