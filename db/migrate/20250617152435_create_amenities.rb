class CreateAmenities < ActiveRecord::Migration[7.1]
  def change
    create_table :amenities do |t|
      t.integer :amenity_type
      t.string :description

      t.timestamps
    end
  end
end
