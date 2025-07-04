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
    (0..@amenity_titles.length).each { |i| @property_amenities << @property.amenities.where(amenity_type: i) }
    @maximum_date = (Date.tomorrow + 1.year).strftime('%F')
    @minimum_date = (Date.today + 2.days).strftime('%F')
    load_reserved_dates
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

  def reservation
    reservation = @property.reservations.new
    reservation.start_date = params[:checkin]
    reservation.end_date = params[:checkout]
    nights = reservation.end_date - reservation.start_date
    reservation.price_cents = nights * @property.price_cents
    reservation.user_id = current_user.id
    if reservation.save
      redirect_to @property, notice: 'Reservation was successfully created.'
    else
      redirect_to @property, notice: 'Reservation was not successfully created.'
    end
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
