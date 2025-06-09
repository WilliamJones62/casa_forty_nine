# frozen_string_literal: true

# This class contains landing page logic
class HomeController < ApplicationController
  def landing
    @property = Property.last
  end
end
