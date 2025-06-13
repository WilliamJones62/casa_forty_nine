# frozen_string_literal: true

# This class contains Property controller logic
class PropertiesController < ApplicationController
  before_action :set_property

  def show; end

  def edit; end

  def update
    if @property.update(property_params)
      # do I need to attach the images individually or can I do them all at once?
      @property.images.attach(params[:property][:images])
      # if params[:property][:images].present?
      #     params[:property][:images].each do |image|
      #       property.images.attach(image)
      #     end
      # end
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
                                     :longitude, :price_cents, :price_currency)
  end
end
