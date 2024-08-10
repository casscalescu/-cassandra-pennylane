class RecipesController < ApplicationController
  def index
    parsed_ingredients = JSON.parse(params[:ingredients])
    ingredients_array = ingredients_array.map { |ingredient| ingredient['value'] }
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
