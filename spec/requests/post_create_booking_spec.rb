# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'POST /create booking dates in same month' do
    before do
      FactoryBot.create(:user)
      Date.today.at_beginning_of_month
      post '/api/v1/users/1/createbooking.json', params: { selected: '{"2024":{"3":[8,9,10]}}' }
    end
    it 'creates a booking' do
      booking = Booking.last
      start_date = Date.new(2024.to_i, 4.to_i, 8)
      expect(booking.start_date).to eq(start_date)
      end_date = Date.new(2024.to_i, 4.to_i, 10)
      expect(booking.end_date).to eq(end_date)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /create booking dates across 2 months' do
    before do
      FactoryBot.create(:user)
      Date.today.at_beginning_of_month
      post '/api/v1/users/1/createbooking.json', params: { selected: '{"2024":{"3":[28,29,30],"4":[1,2,3]}}' }
    end
    it 'creates a booking' do
      booking = Booking.last
      start_date = Date.new(2024.to_i, 4.to_i, 28)
      expect(booking.start_date).to eq(start_date)
      end_date = Date.new(2024.to_i, 5.to_i, 3)
      expect(booking.end_date).to eq(end_date)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /create booking dates across 2 years' do
    before do
      FactoryBot.create(:user)
      Date.today.at_beginning_of_month
      post '/api/v1/users/1/createbooking.json',
           params: { selected: '{"2024":{"11":[28,29,30,31]},"2025":{"0":[1,2,3]}}' }
    end
    it 'creates a booking' do
      booking = Booking.last
      start_date = Date.new(2024.to_i, 12.to_i, 28)
      expect(booking.start_date).to eq(start_date)
      end_date = Date.new(2025.to_i, 1.to_i, 3)
      expect(booking.end_date).to eq(end_date)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
