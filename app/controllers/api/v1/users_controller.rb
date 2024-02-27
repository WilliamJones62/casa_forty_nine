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

      def booking
        # this endpoint createsa new booking from calendar data selected by the user
        booking_dates = BookingDatesConverterService.call(params)
        user = User.find(params[:user_id].to_i)
        booking = user.bookings.new
        booking.start_date = booking_dates[:start_date]
        booking.end_date = booking_dates[:end_date]
        @message = if booking.save
                     'Booking was created!'
                   else
                     'Booking was not created!'
                   end
      end
    end
  end
end
