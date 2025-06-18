class CreateJoinTablePropertiessAmenities < ActiveRecord::Migration[7.1]
  def change
    create_join_table :properties, :amenities do |t|
      # t.index [:property_id, :amenity_id]
      # t.index [:amenity_id, :property_id]
    end
  end
end
