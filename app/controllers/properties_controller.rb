# frozen_string_literal: true

# This class contains Property controller logic
class PropertiesController < ApplicationController
  before_action :set_property

  def show
    set_amenities_loop
    @property_amenities = []
    @amenity_titles = ['', 'Bathroom', 'Bedroom and laundry', 'Heating and cooling', 'Entertainment',
                       'Parking and facilities', 'Internet and office', 'Kitchen and dining',
                       'Outdoor', 'Home safety', 'Services', 'Scenic views', 'Not included']
    (0..@amenity_titles.length).each do |i|
      @property_amenities << @property.amenities.where(amenity_type: i)
    end

    # @views_amenities = @property.amenities.where(amenity_type: 11)
    # @bathroom_amenities = @property.amenities.where(amenity_type: 1)
    # @bedroom_amenities = @property.amenities.where(amenity_type: 2)
    # @entertainment_amenities = @property.amenities.where(amenity_type: 4)
    # @cooling_amenities = @property.amenities.where(amenity_type: 3)
    # @safety_amenities = @property.amenities.where(amenity_type: 9)
    # @internet_amenities = @property.amenities.where(amenity_type: 6)
    # @kitchen_amenities = @property.amenities.where(amenity_type: 7)
    # @outdoor_amenities = @property.amenities.where(amenity_type: 8)
    # @facilities_amenities = @property.amenities.where(amenity_type: 5)
    # @services_amenities = @property.amenities.where(amenity_type: 10)
    # @not_amenities = @property.amenities.where(amenity_type: 12)
  end

  def edit; end

  def update
    if @property.update(property_params)
      @property.images.attach(params[:property][:images])
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit
    end
  end

  def images; end

  def displayimages; end

  def deleteimage
    @property.images.find(params['id']).purge
    render 'displayimages'
  end

  private

  def set_amenities_loop
    amenities_count = @property.amenities.length
    amenities_count = 10 if amenities_count > 10
    @amenities_loop = amenities_count / 2
  end

  def set_property
    @property = Property.last
  end

  def property_params
    params.require(:property).permit(:name, :headline, :description, :address, :city, :state, :country, :latitude,
                                     :longitude, :price_cents, :price_currency, :bedrooms, :beds, :baths, :guests,
                                     amenity_ids: [])
  end
end
