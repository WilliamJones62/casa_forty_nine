class AddLongitudeToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :longitude, :float
  end
end
