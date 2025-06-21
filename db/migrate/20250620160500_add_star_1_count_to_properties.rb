class AddStar1CountToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :star_1_count, :integer
  end
end
