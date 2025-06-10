# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'available_dates' do
    it 'returns the first available date range' do
      user = create(:user)
      property = create(:property)
      create(:reservation, :far_past, user: user, property: property)
      create(:reservation, :past, user: user, property: property)
      create(:reservation, :current, user: user, property: property)
      create(:reservation, :future, user: user, property: property)
      create(:reservation, :far_future, user: user, property: property)
      expect(property.available_dates).to eq([Date.today + 3.days..Date.today + 5.days,
                                              Date.today + 17.days..Date.today + 1.year])
    end
  end
end
