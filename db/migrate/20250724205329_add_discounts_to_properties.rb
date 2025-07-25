class AddDiscountsToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :weekly_discount, :float
    add_column :properties, :monthly_discount, :float
  end
end
