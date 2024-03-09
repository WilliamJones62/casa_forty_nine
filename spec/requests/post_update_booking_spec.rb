# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'POST /update booking, change start date' do
    before do
      user = create(:user_with_middle_bookings)
      calendar = Date.today.at_beginning_of_month.next_month
      year = calendar.year
      month = calendar.month - 1
      post "/api/v1/users/#{user.id}/updatebooking.json",
           params: { selected: "{\"#{year}\":{\"#{month}\":[13,14,15,16]}}" }
    end
    it 'updates a booking' do
      booking = Booking.last
      start_date = Date.today.at_beginning_of_month.next_month + 12.days
      expect(booking.start_date).to eq(start_date)
      end_date = Date.today.at_beginning_of_month.next_month + 15.days
      expect(booking.end_date).to eq(end_date)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /update booking, change end date' do
    before do
      user = create(:user_with_middle_bookings)
      calendar = Date.today.at_beginning_of_month.next_month
      year = calendar.year
      month = calendar.month - 1
      post "/api/v1/users/#{user.id}/updatebooking.json",
           params: { selected: "{\"#{year}\":{\"#{month}\":[11,12,13,14]}}" }
    end
    it 'updates a booking' do
      booking = Booking.last
      start_date = Date.today.at_beginning_of_month.next_month + 10.days
      expect(booking.start_date).to eq(start_date)
      end_date = Date.today.at_beginning_of_month.next_month + 13.days
      expect(booking.end_date).to eq(end_date)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /update booking, change start and end date' do
    before do
      user = create(:user_with_middle_bookings)
      calendar = Date.today.at_beginning_of_month.next_month
      year = calendar.year
      month = calendar.month - 1
      post "/api/v1/users/#{user.id}/updatebooking.json",
           params: { selected: "{\"#{year}\":{\"#{month}\":[9,10,11,12,13,14,15,16,17]}}" }
    end
    it 'updates a booking' do
      booking = Booking.last
      start_date = Date.today.at_beginning_of_month.next_month + 8.days
      expect(booking.start_date).to eq(start_date)
      end_date = Date.today.at_beginning_of_month.next_month + 16.days
      expect(booking.end_date).to eq(end_date)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
