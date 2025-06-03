class Api::UsersController < ApplicationController
    def show
        user = User.find(params[:id])

        render json: user.to_json, status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }.to_json, status: :not_found
    end
end
