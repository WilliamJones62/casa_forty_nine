# frozen_string_literal: true

class AddLatitudeToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :latitude, :float
  end
end
