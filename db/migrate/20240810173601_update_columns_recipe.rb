class UpdateColumnsRecipe < ActiveRecord::Migration[7.1]
  def change
    rename_column :recipes, :name, :title
    remove_column :recipes, :description
    add_column :recipes, :cook_time, :integer
    add_column :recipes, :prep_time, :integer
    add_column :recipes, :ingredients, :string, array: true, default: []
    add_column :recipes, :ratings, :integer
    add_column :recipes, :cuisine, :string
    add_column :recipes, :category, :string
    add_column :recipes, :author, :string
    add_column :recipes, :image, :string
  end
end
