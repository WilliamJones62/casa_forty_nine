# frozen_string_literal: true

# This class contains reviews controller logic
class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property

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

  def load_stripe_card
    Stripe::Customer.create_source(
      stripe_customer.id,
      { source: params['stripeToken'] }
    )
  end

  def load_stripe_charge
    Stripe::Charge.create(
      amount: @reservation.price_cents,
      currency: 'usd',
      source: @stripe_card.id,
      customer: stripe_customer.id
    )
  end

  def route_to_next_action(charge, reservation)
    redirect_to @property, notice: 'Payment failed, please try again.' unless charge.id

    reservation.charge_id = charge.id
    if reservation.save
      redirect_to @property, notice: 'Reservation was successfully created.'
    else
      redirect_to @property, notice: 'Reservation was not successfully created.'
    end
  end

  def stripe_customer
    @stripe_customer ||= if current_user.stripe_id.blank?
                           customer = Stripe::Customer.create(email: current_user.email)
                           current_user.update(stripe_id: customer.id)
                           customer
                         else
                           Stripe::Customer.retrieve(current_user.stripe_id)
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
