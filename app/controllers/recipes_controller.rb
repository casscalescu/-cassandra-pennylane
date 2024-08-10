class RecipesController < ApplicationController
  def index
    user_ingredients = JSON.parse(params[:ingredients])
    ingredients_array = user_ingredients.map { |ingredient| ingredient['value'] }
    @recipes = Recipe.all.select do |recipe|
      ingredients_array.all? do |ingredient|
        recipe.ingredients.any? { |x| x.downcase.include?(ingredient.downcase) }
      end
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
