class AddBedroomsToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :bedrooms, :integer
  end
end
