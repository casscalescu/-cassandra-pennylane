class RecipesController < ApplicationController
  def index
    if params[:ingredients] != ""
      user_ingredients = JSON.parse(params[:ingredients])
      ingredients_array = user_ingredients.map { |ingredient| ingredient['value'] }
      filter_recipes = Recipe.all.select do |recipe|
        ingredients_array.all? do |ingredient|
          # split to look at each word => avoid "apple" matching "pineapple" in a String
          recipe.ingredients.any? { |x| x.downcase.split.include?(ingredient.downcase) }
        end
      end
      if filter_recipes.count > 1
        @recipes = filter_recipes.sort_by { |recipe| recipe.ingredients.count - ingredients_array.count }.first(10)
      else
        suggested_recipes = Recipe.all.select do |recipe|
          ingredients_array.any? do |user_ingredient|
            recipe.ingredients.any? do |recipe_ingredient|
              recipe_ingredient.split.include?(user_ingredient.downcase)
            end
          end
        end
        @recipes = suggested_recipes.shuffle.first(10)
      end
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
