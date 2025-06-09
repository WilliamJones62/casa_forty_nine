require "rails_helper"
require 'spec_helper'

RSpec.describe 'HomeController', type: :request do
  describe "landing" do
    it "is successful" do
      @property = create (:property)
      get home_landing_url
      expect(response).to be_successful
    end
  end
end
