class AddCategoryIdToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :category_id, :integer
  end
end
