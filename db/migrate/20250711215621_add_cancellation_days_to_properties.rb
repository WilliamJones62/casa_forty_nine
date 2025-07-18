class AddCancellationDaysToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :cancellation_days, :integer
  end
end
