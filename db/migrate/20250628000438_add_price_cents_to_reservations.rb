class AddPriceCentsToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :price_cents, :integer
  end
end
