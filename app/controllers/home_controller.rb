class HomeController < ApplicationController
  def landing
    @property = Property.last
  end
end
