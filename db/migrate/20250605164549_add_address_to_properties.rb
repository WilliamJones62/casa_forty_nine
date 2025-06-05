class AddAddressToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :address, :string
  end
end
