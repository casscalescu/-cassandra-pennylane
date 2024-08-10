# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'json'
require 'pry-byebug'

recipes_json = Rails.root.join('recipes-en.json')
serialized_recipes = File.read(recipes_json)
recipes = JSON.parse(serialized_recipes)

puts 'Cleaning DB'
Recipe.destroy_all

puts 'Seeding recipes'

recipes.each do |recipe|
    new_recipe = Recipe.new
    new_recipe.title = recipe['title']
    new_recipe.cook_time = recipe['cook_time']
    new_recipe.prep_time = recipe['prep_time']
    new_recipe.ingredients = recipe['ingredients']
    new_recipe.ratings = recipe['ratings']
    new_recipe.cuisine = recipe['cuisine']
    new_recipe.category = recipe['category']
    new_recipe.author = recipe['author']
    new_recipe.image = recipe['image']
    new_recipe.save!
end

puts 'Seeding complete'

