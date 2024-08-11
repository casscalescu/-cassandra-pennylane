class RecipesController < ApplicationController
  def index
    if params[:ingredients] != ""
      user_ingredients = JSON.parse(params[:ingredients])
      ingredients_array = user_ingredients.map { |ingredient| ingredient['value'] }
      filter_recipes = Recipe.all.select do |recipe|
        ingredients_array.all? do |ingredient|
          recipe.ingredients.any? { |x| x.downcase.split.include?(ingredient.downcase) }
        end
      end
      @recipes = filter_recipes.sort_by { |recipe| recipe.ingredients.count - ingredients_array.count }.first(10)
      @message = "Your top results..."
    else
      @recipes = Recipe.order('RANDOM()').limit(10)
      @message = "Oops you didn't tell us what ingredients you have... here's some recipes you may like"
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
