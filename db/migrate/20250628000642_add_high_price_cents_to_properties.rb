class AddHighPriceCentsToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :high_price_cents, :integer
  end
end
