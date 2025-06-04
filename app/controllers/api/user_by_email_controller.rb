class Api::UserByEmailController < ApplicationController
    def show
        user = User.find_by!(email: params[:email])

        render json: user.to_json, status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }.to_json, status: :not_found
    end
end
