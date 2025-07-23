# frozen_string_literal: true

# This class contains Application controller logic
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_reservations
  before_action :load_review_reservations

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :city, :state, :country, :email, :password, :image)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :city, :state, :country, :email, :password, :current_password, :image)
    end
  end

  def load_reservations
    return unless user_signed_in?

    reservations = if current_user.admin
                     Reservation.future_reservations
                   else
                     current_user.reservations.future_reservations
                   end

    session[:reservations] = true if reservations.length.positive?
  end

  def load_review_reservations
    return unless user_signed_in?

    reservations = if current_user.admin
                     Reservation.past_reservations
                   else
                     current_user.reservations.past_reservations
                   end

    session[:review_reservations] = true if reservations.length.positive?
  end
end
