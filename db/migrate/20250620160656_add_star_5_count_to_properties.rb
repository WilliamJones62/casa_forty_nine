class AddStar5CountToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :star_5_count, :integer
  end
end
