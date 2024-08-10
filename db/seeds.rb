# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'json'

recipes_json = Rails.root.join('recipes-en.json')
serialized_recipes = File.read(recipes_json)
recipes = JSON.parse(serialized_recipes)

pp recipes.last

