# frozen_string_literal: true

# Each booking belongs to a particular User
class Booking < ApplicationRecord
  belongs_to :user
  validates :start_date, presence: true
  validates :end_date, presence: true
end
