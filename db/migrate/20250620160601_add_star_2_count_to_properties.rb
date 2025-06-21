class AddStar2CountToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :star_2_count, :integer
  end
end
