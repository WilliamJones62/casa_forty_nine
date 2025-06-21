class AddStar3CountToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :star_3_count, :integer
  end
end
