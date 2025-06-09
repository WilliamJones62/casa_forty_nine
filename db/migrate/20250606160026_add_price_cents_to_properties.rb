# frozen_string_literal: true

class AddPriceCentsToProperties < ActiveRecord::Migration[7.1]
  def change
    add_monetize :properties, :price, amount: { null: true, default: nil }, currency: { null: true, default: nil }
  end
end
