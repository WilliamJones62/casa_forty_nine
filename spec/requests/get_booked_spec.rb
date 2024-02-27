# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET /booked no booked days' do
    before do
      user = FactoryBot.create(:user)
      calendar = Date.today.at_beginning_of_month.next_month
      get "/api/v1/users/#{user.id}/booked.json?year=#{calendar.year}&month=#{calendar.month - 1}"
    end
    it 'returns no booked days' do
      parsed_json = JSON.parse(response.body)
      expect(parsed_json['booked'].length).to equal(0)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET /booked with booked days overlaping the start of the month' do
    before do
      user = FactoryBot.create(:user)
      calendar = Date.today.at_beginning_of_month.next_month
      create(:booking, :overlap_start_of_month).user
      get "/api/v1/users/#{user.id}/booked.json?year=#{calendar.year}&month=#{calendar.month - 1}"
    end
    it 'returns booked days' do
      parsed_json = JSON.parse(response.body)
      expect(parsed_json['booked']).to eq([1, 2, 3, 4])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET /booked with booked days overlaping the end of the month' do
    before do
      user = FactoryBot.create(:user)
      calendar = Date.today.at_beginning_of_month.next_month
      create(:booking, :overlap_end_of_month).user
      get "/api/v1/users/#{user.id}/booked.json?year=#{calendar.year}&month=#{calendar.month - 1}"
    end
    it 'returns booked days' do
      parsed_json = JSON.parse(response.body)
      expect(parsed_json['booked'].length).to be >= (2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET /booked with booked days in the middle of the month' do
    before do
      user = FactoryBot.create(:user)
      calendar = Date.today.at_beginning_of_month.next_month
      create(:booking, :middle_of_month).user
      get "/api/v1/users/#{user.id}/booked.json?year=#{calendar.year}&month=#{calendar.month - 1}"
    end
    it 'returns booked days' do
      parsed_json = JSON.parse(response.body)
      expect(parsed_json['booked']).to eq([11, 12, 13, 14, 15, 16])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET /booked with booked days for 2 bookings' do
    before do
      user = FactoryBot.create(:user)
      calendar = Date.today.at_beginning_of_month.next_month
      create(:booking, :middle_of_month).user
      create(:booking, :overlap_start_of_month).user
      get "/api/v1/users/#{user.id}/booked.json?year=#{calendar.year}&month=#{calendar.month - 1}"
    end
    it 'returns booked days' do
      parsed_json = JSON.parse(response.body)
      expect(parsed_json['booked']).to eq([1, 2, 3, 4, 11, 12, 13, 14, 15, 16])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
