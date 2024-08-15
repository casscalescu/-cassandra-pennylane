class RecipesController < ApplicationController
  def index
    if params[:ingredients].present?
      # match all ingredients
      user_ingredients = JSON.parse(params[:ingredients])
      ingredients_array = user_ingredients.map { |ingredient| ingredient['value'] }
      recipe_results = Recipe.recipes_exact_match(ingredients_array)
      @recipes = recipe_results.sort_by { |recipe| recipe.ingredients.count - ingredients_array.count }.first(10)
      @message = "Your top results..."
      # match some ingredients
      if recipe_results.count < 10
        suggested_recipes = Recipe.recipes_conditional_match(ingredients_array)
        @additional_recipes = suggested_recipes.shuffle.first(10)
        @additional_message = "Since your results are so short, here's some additional recipes to inspire you..."
      end
    # no ingredients passed
    else
      @recipes = Recipe.random_recipes
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
end
