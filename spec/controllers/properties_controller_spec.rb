# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PropertiesController', type: :request do
  describe 'show' do
    it 'is successful' do
      property = create(:property)
      get property_path(property)
      expect(response).to be_successful
    end
  end
end
