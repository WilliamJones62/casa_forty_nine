# frozen_string_literal: true

# Each booking belongs to a particular User
class Booking < ApplicationRecord
  belongs_to :user
end
