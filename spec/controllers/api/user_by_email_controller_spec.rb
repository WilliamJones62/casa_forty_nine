require "rails_helper"
require 'spec_helper'

RSpec.describe 'Api::UserByEmailController', type: :request do
  describe "show" do
    let(:headers) do
        {'ACCEPT' => 'application/json'}
    end
    context "user exists"
        it "responds with 'success'" do
            user = create(:user)
            get api_user_by_email_path, params: {email: user.email}, headers: headers
            expect(response).to be_successful
        end
    context "user does not exists"
        it "responds with 'not found'" do
            get api_user_by_email_path, params: {email: "junk@junk.com"}, headers: headers
            expect(response.status).to eq 404
        end
  end
end
