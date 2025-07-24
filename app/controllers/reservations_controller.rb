# frozen_string_literal: true

# This class contains reviews controller logic
class ReservationsController < ApplicationController
  include StripeModule

  before_action :authenticate_user!
  before_action :set_property
  before_action :set_reservation, only: %i[edit change destroy]

  def index
    @reservations = if current_user.admin
                      Reservation.future_reservations.order(:start_date)
                    else
                      current_user.reservations.future_reservations.order(:start_date)
                    end
  end

  def edit
    authorize @reservation
    load_edit_instance_variables
    @selectedin = @reservation.start_date.strftime('%F')
    @selectedout = @reservation.end_date.strftime('%F')
    load_reserved_dates
    set_date_boundaries
  end

  def change
    authorize @reservation
    redirect_to reservations_url, notice: 'Reservation was successfully changed.'
  end

  def destroy
    # @reservation.destroy
    redirect_to reservations_url, notice: 'Reservation was successfully cancelled.'
  end

  def confirm
    @reservation = load_reservation_fields
    @stripe_card = load_stripe_card
    charge = load_stripe_charge
    route_to_next_action(charge, @reservation)
  end

  private

  def set_property
    @property = Property.last
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def load_edit_instance_variables
    @edit = true
    @checkin = @reservation.start_date.to_s
    @checkout = @reservation.end_date.to_s
    @nights = @reservation.end_date - @reservation.start_date
    @price = @nights * (@property.price_cents / 100)
  end

  def load_reserved_dates
    @reserved_dates = []
    @property.reservations.future_reservations.all.each do |future_reservation|
      next unless future_reservation.id != @reservation.id

      reserved_dates_load(future_reservation)
    end
  end

  def reserved_dates_load(future_reservation)
    start_date = future_reservation.start_date < Date.today ? Date.today : future_reservation.start_date
    ((start_date + 1.day)..(future_reservation.end_date + 1.day)).each do |date|
      @reserved_dates << date.strftime('%F')
    end
  end

  def set_date_boundaries
    @maximum_date = (Date.tomorrow + 1.year).strftime('%F')
    @minimum_date = (Date.today + 2.days).strftime('%F')
  end

  def route_to_next_action(charge, reservation)
    redirect_to @property, notice: 'Payment failed, please try again.' unless charge.id

    reservation.charge_id = charge.id
    if reservation.save
      ReservationMailer.confirm_reservation(current_user, reservation).deliver_now
      redirect_to root_path, notice: 'Reservation was successfully created.'
    else
      redirect_to @property, notice: 'Reservation was not successfully created.'
    end
  end

  def load_reservation_fields
    reservation = @property.reservations.new
    reservation = load_reservation_dates(reservation)
    reservation.price_cents = calculate_price(reservation.end_date, reservation.start_date)
    reservation.user_id = current_user.id
    reservation
  end

  def load_reservation_dates(reservation)
    reservation.start_date = params.dig('checkin', 'strip').to_date
    reservation.end_date = params.dig('checkout', 'strip').to_date
    reservation
  end

  def calculate_price(end_date, start_date)
    nights = end_date - start_date
    nights * @property.price_cents
  end
end
