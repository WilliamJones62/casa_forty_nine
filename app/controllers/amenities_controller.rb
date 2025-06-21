# frozen_string_literal: true

# This class contains Amenities controller logic
class AmenitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_amenity, only: %i[edit update destroy displayimage]

  def index
    @amenities = Amenity.all
  end

  def new
    @amenity = Amenity.new
  end

  def create
    @amenity = Amenity.new(amenity_params)

    if @amenity.save
      @amenity.image.attach(params[:amenity][:image])
      redirect_to amenities_path, notice: 'Amenity was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @amenity.update(amenity_params)
      @amenity.image.attach(params[:amenity][:image])
      redirect_to amenities_path, notice: 'Amenity was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @amenity.destroy
    redirect_to amenities_url, notice: 'Amenity was successfully deleted.'
  end

  def displayimage; end

  private

  def set_amenity
    @amenity = Amenity.find(params[:id])
  end

  def amenity_params
    params.require(:amenity).permit(:amenity_type, :description)
  end
end
