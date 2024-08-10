class UpdateRatingsType < ActiveRecord::Migration[7.1]
  def change
    change_column :recipes, :ratings, :float
  end
end
