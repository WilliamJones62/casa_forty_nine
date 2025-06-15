class AddBedsToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :beds, :integer
  end
end
