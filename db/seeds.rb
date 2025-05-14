# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"
require "open-url"

puts "CLeaning the DB"
Bookmark.destroy_all
Category.destroy_all
Recipe.destroy_all

puts "Creating new recipes..."

recipe = Recipe.create!(name: "Spaghetti Bolognese", description: "Beef mince and tomato spaghetti", image_url: "https://plus.unsplash.com/premium_photo-1664478291780-0c67f5fb15e6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c3BhZ2hldHRpJTIwYm9sb2duZXNlfGVufDB8fDB8fHww", rating: 4.4)

recipe = Recipe.create!(name: "Lasagne", description: "Layers of beef mince, bechamel sauce and authentic italian pasta sheets", image_url: "https://images.unsplash.com/photo-1709429790175-b02bb1b19207?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bGFzYWduZXxlbnwwfHwwfHx8MA%3D%3D", rating: 5)

recipe = Recipe.create!(name: "Carbonnara", description: "Creamy, pancetta pasta", image_url: "https://images.unsplash.com/photo-1633337474564-1d9478ca4e2e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGNhcmJvbmFyYXxlbnwwfHwwfHx8MA%3D%3D", rating: 4)

recipe = Recipe.create!(name: "Roast beek", description: "Staple of the English Sunday roast", image_url: "https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cm9hc3QlMjBiZWVmfGVufDB8fDB8fHww", rating: 5)

recipe = Recipe.create!(name: "Ramen Noodles", description: "Quentissential noodle dish", image_url: "https://images.unsplash.com/photo-1672338071242-88184df8fb4b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHJhbWVuJTIwbm9vZGxlfGVufDB8fDB8fHww", rating: 3.5)

recipe = Recipe.create!(name: "Steamed Broccoli", description: "Vegan health kick food", image_url: "https://plus.unsplash.com/premium_photo-1702313776847-b90ae4bd048a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8c3RlYW1lZCUyMGJyb2Njb2xpfGVufDB8fDB8fHww", rating: 1)

puts "#{Recipe.count} recipes created"

def recipe_builder(id)
  url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"
  meal_serialized = URI.parse(url).read
  meal = JSON.parse(meal_serialized)["meals"][0]

  Recipe.create!{
    name: meal["strMeal"],
    description: meal["strInstructions"],
    image_url: meal["strMealThumb"],
    rating: rand(2..5.0).round(1)
  };
  end
end

categories = ["Italian", "japanese", "burger", "Chinese"]

categories.each do |category|
  url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{category}"
  recipe_list = URI.parse(url).read
  recipes = JSON.parse(recipe_list)
  recipes["meals"].take(5).each do |recipe|
    recipe_builder(recipe["idMeal"])
  end
end

puts "Done! #{Recipe.count} recipes created"
