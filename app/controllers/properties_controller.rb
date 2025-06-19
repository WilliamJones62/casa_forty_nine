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
