class AddHighStartDateToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :high_start_date, :date
  end
end
