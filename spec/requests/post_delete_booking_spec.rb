# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'POST /delete booking' do
    before do
      user = create(:user_with_middle_bookings)
      calendar = Date.today.at_beginning_of_month.next_month
      year = calendar.year
      month = calendar.month - 1
      post "/api/v1/users/#{user.id}/deletebooking.json",
           params: { selected: "{\"#{year}\":{\"#{month}\":[14]}}" }
    end
    it 'deletes a booking' do
      booking = Booking.last
      expect(booking).to eq(nil)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
