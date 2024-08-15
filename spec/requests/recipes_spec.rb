require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /index" do
    before do
        Recipe.create(title: 'Apple Banana Smoothie', ingredients: ['apple', 'banana'])
        Recipe.create(title: 'Banana Strawberry Muffins', ingredients: ['banana', 'strawberry'])
        Recipe.create(title: 'Strawberry Apple Pie', ingredients: ['strawberry', 'apple'])
        Recipe.create(title: 'Apple Cinnamon Oatmeal', ingredients: ['apple'])
        Recipe.create(title: 'Banana Pancakes', ingredients: ['banana'])
        Recipe.create(title: 'Apple Strawberry Salad', ingredients: ['apple', 'strawberry'])
        Recipe.create(title: 'Strawberry Banana Smoothie', ingredients: ['banana', 'strawberry'])
        Recipe.create(title: 'Banana Bread Pudding', ingredients: ['banana'])
        Recipe.create(title: 'Apple Turnovers', ingredients: ['apple'])
        Recipe.create(title: 'Chocolate Cake', ingredients: ['flour', 'cocoa powder', 'sugar'])
        Recipe.create(title: 'Vanilla Cupcakes', ingredients: ['flour', 'sugar', 'butter', 'eggs'])
        Recipe.create(title: 'Lemon Bars', ingredients: ['sugar', 'butter', 'eggs', 'lemon'])
    end

    let(:ingredients_json_all) { [{ 'value' => 'strawberry' }, { 'value' => 'banana' }].to_json }
    let(:ingredients_json_any) { [{ 'value' => 'apple' }, { 'value' => 'banana' }, { 'value' => 'strawberry' }].to_json }
    
    it "returns recipes where each contains all of the ingredients" do   
        get recipes_path, params: { ingredients: ingredients_json_all }

        expect(response).to have_http_status(:ok)

        doc = Nokogiri::HTML(response.body)

        recipes = doc.css('.recipe-results li a').map(&:text)
        
        expect(recipes).to include('Banana Strawberry Muffins')
        expect(recipes).to include('Strawberry Banana Smoothie')
    end

    it "returns recipes where each contains at least 1 of the ingredients" do
        get recipes_path, params: { ingredients: ingredients_json_any }

        expect(response).to have_http_status(:ok)

        doc = Nokogiri::HTML(response.body)

        expected_recipes = [
            'Apple Banana Smoothie',
            'Banana Strawberry Muffins',
            'Strawberry Apple Pie',
            'Apple Cinnamon Oatmeal',
            'Banana Pancakes',
            'Apple Strawberry Salad',
            'Strawberry Banana Smoothie',
            'Banana Bread Pudding',
            'Apple Turnovers'
        ]

        recipes = doc.css('.recipe-results li a').map(&:text)
        
        expected_recipes.each do |recipe|
            expect(recipes).to include(recipe)
        end
    end
  end
end
