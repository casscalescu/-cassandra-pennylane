class Recipe < ApplicationRecord
    include PgSearch::Model

    pg_search_scope :search_by_ingredients,
        against: :ingredients,
        using: {
            tsearch: { prefix: true }
        }
    
    def self.recipes_exact_match(ingredients_array)
        query_string = ingredients_array.map(&:downcase).join(' & ')
        search_by_ingredients(query_string)
    end

    def self.recipes_conditional_match(ingredients_array)
        Recipe.all.select do |recipe|
          ingredients_array.any? do |user_ingredient|
            recipe.ingredients.any? do |recipe_ingredient|
              recipe_ingredient.split.include?(user_ingredient)
            end
          end
        end
    end

    def self.random_recipes
        order('RANDOM()').limit(10)
    end

    def display_matched_ingredient(ingredients_array)
        ingredients_array.select do |ingredient|
            self.ingredients.any? do |recipe_ingredient|
              recipe_ingredient.split.include?(ingredient)
            end
        end.join(", ")
    end
end
