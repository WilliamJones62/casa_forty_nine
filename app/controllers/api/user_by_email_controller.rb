# frozen_string_literal: true

module Api
  # This class contains find User by email logic
  class UserByEmailController < ApplicationController
    def show
      session[:email] = params[:email]

      user = User.find_by!(email: params[:email])

      render json: user.to_json, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }.to_json, status: :not_found
    end
  end
end
