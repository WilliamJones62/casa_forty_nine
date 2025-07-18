# frozen_string_literal: true

# This module contains Stripe logic
module StripeModule
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

  def stripe_customer
    @stripe_customer ||= if current_user.stripe_id.blank?
                           customer = Stripe::Customer.create(email: current_user.email)
                           current_user.update(stripe_id: customer.id)
                           customer
                         else
                           Stripe::Customer.retrieve(current_user.stripe_id)
                         end
  end
end
