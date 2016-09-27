class AddRecipeIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :recipe_id, :integer
  end
end
