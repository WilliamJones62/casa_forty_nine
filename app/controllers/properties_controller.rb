# frozen_string_literal: true

# This class contains Property controller logic
class PropertiesController < ApplicationController
  before_action :set_property

  def show; end

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

  def set_property
    @property = Property.last
  end

  def property_params
    params.require(:property).permit(:name, :headline, :description, :address, :city, :state, :country, :latitude,
                                     :longitude, :price_cents, :price_currency, :bedrooms, :beds, :baths, :guests)
  end
end
