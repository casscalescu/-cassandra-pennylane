class RecipesController < ApplicationController
  def index
    if params[:ingredients].present?
      user_ingredients = JSON.parse(params[:ingredients])
      @ingredients_array = user_ingredients.map { |ingredient| ingredient['value'] }

      # Exact match
      recipe_results = Recipe.recipes_exact_match(@ingredients_array)
      @recipes = recipe_results
        .sort_by { |recipe| recipe.ingredients.count - @ingredients_array.count }
        .first(10)

      @message = @recipes.empty? ? "Oops we couldn't find recipes with all your ingredients..." : "Your top results..."
      
      # Conditional match
      if recipe_results.size < 10
        suggested_recipes = Recipe.recipes_conditional_match(@ingredients_array)
        @recipe_ids = @recipes.map(&:id)
        recipes_filtered = suggested_recipes.reject { |recipe| @recipe_ids.include?(recipe.id) }
        @additional_recipes = recipes_filtered.shuffle.first(10 - recipe_results.size)
        @additional_message = @additional_recipes.empty? ? "" : "Since your results are so short, here's some additional recipes to inspire you..."
      end
    else
      # No ingredients passed
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
