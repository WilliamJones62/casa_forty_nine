# frozen_string_literal: true

# service to convert calendar selected dates to the start and end dates
class BookingFinderService < ApplicationService
  def initialize(booking_dates, user)
    @booking_dates = booking_dates
    @user = user
  end

  def call
    # get all future bookings for this user
    Date.today
    # bookings = @user.bookings.where(start_date: date..)
    bookings = @user.bookings
    # need to find the booking that overlaps the new start/end dates
    i = 0
    while i < bookings.length
      if (bookings[i][:start_date] <= @booking_dates[:end_date]) ||
         (bookings[i][:end_date] >= @booking_dates[:start_date])
        # this is the booking that changed
        return bookings[i]
      end

      i = 1 + 1
    end
  end
end
