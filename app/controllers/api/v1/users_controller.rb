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

      def createbooking
        # this endpoint createsa new booking from calendar data selected by the user
        change_booking_table('create')
      end

      def updatebooking
        #  this endpoint changes the start and/or end dates for an existing booking
        change_booking_table('update')
      end

      private

      def change_booking_table(action)
        @booking_dates = BookingDatesConverterService.call(params)
        @user = User.find(params[:user_id].to_i)
        booking = load_booking(action)
        booking.start_date = @booking_dates[:start_date]
        booking.end_date = @booking_dates[:end_date]
        @message = if booking.save
                     "Booking was #{action}d!"
                   else
                     "Booking was not #{action}d!"
                   end
      end

      def load_booking(action)
        if action == 'create'
          @user.bookings.new
        else
          BookingFinderService.call(@booking_dates, @user)
        end
      end
    end
  end
end
