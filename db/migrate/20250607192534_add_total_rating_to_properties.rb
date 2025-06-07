class AddTotalRatingToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :total_rating, :integer
  end
end
