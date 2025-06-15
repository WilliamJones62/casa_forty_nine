class AddBathsToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :baths, :integer
  end
end
