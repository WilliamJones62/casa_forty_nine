# frozen_string_literal: true

#  API endpoint methods go here.
module Api
  module V1
    # V1 endpoints go here.
    class UsersController < ApplicationController
      def booked
        # this endpoint returns all booked days for the calendar month.
        load_variables
        return if in_the_past?([@calendar_year, @calendar_month], [@year_today, @month_today])

        find_bookings_for_the_month
        return unless @bookings.length.positive?

        # found at least one booking for this month. Need to return a list of booked days.
        load_booked_days
      end

      private

      def in_the_past?(calendar_ym, today_ym)
        (calendar_ym <=> today_ym) == -1
      end

      def load_variables
        @calendar_year = params[:year].to_i
        # the month on the front end is one less than the actual month
        @calendar_month = params[:month].to_i + 1
        @year_today = Date.today.year
        @month_today = Date.today.month
        @booked_days = []
      end

      def find_bookings_for_the_month
        @calendar_month_start = Date.new(@calendar_year, @calendar_month, 1)
        @calendar_month_end = Date.new(@calendar_year, @calendar_month, -1)
        @bookings =
          Booking.where(start_date: ...@calendar_month_end).where(end_date: @calendar_month_start...).order(:start_date)
      end

      def load_booked_days
        @bookings.each do |b|
          (find_booking_start(b)..find_booking_end(b)).each do |i|
            @booked_days.push(i)
          end
        end
      end

      def find_booking_start(booking)
        if booking.start_date < @calendar_month_start
          1
        else
          booking.start_date.day.to_i
        end
      end

      def find_booking_end(booking)
        if booking.end_date > @calendar_month_end
          @calendar_month_end.day.to_i
        else
          booking.end_date.day.to_i
        end
      end
    end
  end
end
