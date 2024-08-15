class Recipe < ApplicationRecord
    def self.recipes_exact_match(ingredients_array)
        ingredients_array.map(&:downcase)

        Recipe.all.select do |recipe|
            ingredients_array.all? do |ingredient|
                recipe.ingredients.any? { |x| x.downcase.split.include?(ingredient) }
            end
        end
    end

    def self.recipes_conditional_match(ingredients_array)
        ingredients_array.map(&:downcase)

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
end
