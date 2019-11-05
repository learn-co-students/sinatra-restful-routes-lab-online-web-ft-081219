class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :Recipes do |x|
      x.string :name 
      x.string :ingredients
      x.string :cook_time
    end
  end
end
