class AddHighEndDateToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :high_end_date, :date
  end
end
