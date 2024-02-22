# frozen_string_literal: true

#  API endpoint methods go here.
module Api
  module V1
    # V1 endpoints go here.
    class UsersController < ApplicationController
      def booked
        # this endpoint returns all booked days for the calendar month.
        @booked_days = BookedDaysFinderService.call(params)
      end
    end
  end
end
