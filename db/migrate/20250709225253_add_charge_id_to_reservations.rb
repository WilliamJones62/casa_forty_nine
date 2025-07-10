class AddChargeIdToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :charge_id, :string
  end
end
