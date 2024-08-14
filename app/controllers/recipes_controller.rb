class RecipesController < ApplicationController
  def index
    if params[:ingredients].present?
      user_ingredients = JSON.parse(params[:ingredients])
      ingredients_array = user_ingredients.map { |ingredient| ingredient['value'] }
      recipe_results = recipes_exact_match(ingredients_array)
      @recipes = recipe_results.sort_by { |recipe| recipe.ingredients.count - ingredients_array.count }.first(10)
      @message = "Your top results..."
      if recipe_results.count < 10
        suggested_recipes = recipes_conditional_match(ingredients_array)
        @additional_recipes = suggested_recipes.shuffle.first(10)
        @additional_message = "Some additional recipes containing some of your ingredients for some extra inspiration..."
      end 
    else
      @recipes = recipes_random
      @message = "Oops you didn't tell us what ingredients you have... here's some recipes you might like"
    end
  end

  def show
    set_recipe
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipes_exact_match(ingredients_array)
    ingredients_array = ingredients_array.map(&:downcase) # Normalize the ingredient names

    Recipe.all.select do |recipe|
      ingredients_array.all? do |ingredient|
        # split to look at each word => avoid "apple" matching "pineapple" in a String
        recipe.ingredients.any? { |x| x.downcase.split.include?(ingredient.downcase) }
      end
    end
  end

  def recipes_conditional_match(ingredients_array)
    Recipe.all.select do |recipe|
      ingredients_array.any? do |user_ingredient|
        recipe.ingredients.any? do |recipe_ingredient|
          recipe_ingredient.split.include?(user_ingredient.downcase)
        end
      end
    end
  end

  def recipes_random
    Recipe.order('RANDOM()').limit(10)
  end
end
