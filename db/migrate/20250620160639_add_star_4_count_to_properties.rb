class AddStar4CountToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :star_4_count, :integer
  end
end
