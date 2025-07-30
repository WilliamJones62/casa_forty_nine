# frozen_string_literal: true

# This class contains Property controller logic
class PropertiesController < ApplicationController
  before_action :set_property

  def show
    set_amenities_loop
    initialize_instance_variables
    @amenity_titles = ['', 'Bathroom', 'Bedroom and laundry', 'Heating and cooling', 'Entertainment',
                       'Parking and facilities', 'Internet and office', 'Kitchen and dining',
                       'Outdoor', 'Home safety', 'Services', 'Scenic views', 'Not included']
    (0..@amenity_titles.length).each { |i| @property_amenities << @property.amenities.where(amenity_type: i) }
    set_date_boundaries
    load_reserved_dates
  end

  def edit
    authorize @property
  end

  def update
    authorize @property
    if @property.update(property_params)
      @property.images.attach(params[:property][:images])
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit
    end
  end

  def images; end

  def displayimages
    authorize @property
  end

  def deleteimage
    authorize @property
    @property.images.find(params['id']).purge
    render 'displayimages'
  end

  def reservation
    @checkin = params[:checkin]
    @checkout = params[:checkout]
    @price = params[:formprice]
    @selectedin = @checkin.to_date
    @selectedout = @checkout.to_date
    @nights = @selectedout - @selectedin
    @selectedin = @selectedin.strftime('%F')
    @selectedout = @selectedout.strftime('%F')
    load_reserved_dates
    set_date_boundaries
  end

  private

  def load_reserved_dates
    @reserved_dates = []
    @property.reservations.future_reservations.all.each do |fr|
      start_date = fr.start_date < Date.today ? Date.today : fr.start_date
      ((start_date + 1.day)..(fr.end_date + 1.day)).each do |date|
        @reserved_dates << date.strftime('%F')
      end
    end
  end

  def set_amenities_loop
    amenities_count = @property.amenities.length
    amenities_count = 10 if amenities_count > 10
    @amenities_loop = amenities_count / 4
  end

  def set_date_boundaries
    @maximum_date = (Date.tomorrow + 1.year).strftime('%F')
    @minimum_date = (Date.today + 2.days).strftime('%F')
  end

  def set_property
    @property = Property.last
  end

  def initialize_instance_variables
    @property_amenities = []
    @checkin = ''
    @checkout = ''
    @nights = 0
    @price = 0
  end

  def property_params
    params.require(:property).permit(:name, :headline, :description, :address, :city, :state, :country, :latitude,
                                     :longitude, :price_cents, :price_currency, :bedrooms, :beds, :baths, :guests,
                                     :cancellation_days, :weekly_discount, :monthly_discount, :high_price_cents, 
                                     :high_start_date, :high_end_date, amenity_ids: [])
  end
end
