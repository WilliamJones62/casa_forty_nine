# frozen_string_literal: true

# This class contains Reservation model logic
class Reservation < ApplicationRecord
  belongs_to :property
  belongs_to :user
  has_one :review

  validates_presence_of :start_date
  validates_presence_of :end_date

  scope :future_reservations, -> { where('end_date > ?', Date.today) }
  scope :past_reservations, -> { where('end_date < ?', Date.today + 1) }
end
