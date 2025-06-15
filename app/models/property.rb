# frozen_string_literal: true

# This class contains Property model logic
class Property < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :headline
  validates_presence_of :description
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :country
  validates_presence_of :bedrooms
  validates_presence_of :beds
  validates_presence_of :baths
  validates_presence_of :guests

  monetize :price_cents, allow_nil: true

  has_many_attached :images, dependent: :destroy
  has_many :reviews, as: :reviewable
  has_many :reservations, dependent: :destroy
  has_many :reserved_users, through: :reservations, source: :user

  def available_dates
    available_dates_array = []
    unavailable_dates = reservations.future_reservations.order(:start_date)
    start_date = find_start_date
    available_dates_array, start_date = load_available_dates(unavailable_dates, start_date, available_dates_array)
    available_dates_array << (start_date..(Date.today + 1.year)) if start_date < Date.today + 1.year
    available_dates_array
  end

  def find_start_date
    tomorrow = Date.tomorrow
    if reservations.past_reservations.order(:start_date).last
      start_date = reservations.past_reservations.order(:start_date).last.end_date + 1.day
    end
    return tomorrow if !start_date || start_date < tomorrow

    start_date
  end

  def load_available_dates(unavailable_dates, start_date, available_dates_array)
    unavailable_dates.each do |u|
      end_date = u.start_date - 1.day
      available_dates_array << (start_date..end_date) if start_date < end_date
      start_date = u.end_date + 1
    end
    [available_dates_array, start_date]
  end
end
