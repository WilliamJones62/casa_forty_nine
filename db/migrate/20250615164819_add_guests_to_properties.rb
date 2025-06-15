class AddGuestsToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :guests, :integer
  end
end
