# frozen_string_literal: true

# Controller for application
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
end
