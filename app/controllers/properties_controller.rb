# frozen_string_literal: true

# This class contains Property controller logic
class PropertiesController < ApplicationController
  def show
    @property = Property.last
  end
end
