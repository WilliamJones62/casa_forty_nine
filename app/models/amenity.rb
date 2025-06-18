# frozen_string_literal: true

# This class contains Amenity model logic
class Amenity < ApplicationRecord
  validates_presence_of :amenity_type
  validates_presence_of :description

  has_one_attached :image, dependent: :destroy
  has_and_belongs_to_many :properties

  scope :views, -> { where('amenity_type > ?', 11) }
  scope :bathroom, -> { where('amenity_type > ?', 1) }
  scope :bedroom, -> { where('amenity_type > ?', 2) }
  scope :entertainment, -> { where('amenity_type > ?', 4) }
  scope :cooling, -> { where('amenity_type > ?', 3) }
  scope :safety, -> { where('amenity_type > ?', 9) }
  scope :internet, -> { where('amenity_type > ?', 7) }
  scope :kitchen, -> { where('amenity_type > ?', 6) }
  scope :outdoor, -> { where('amenity_type > ?', 8) }
  scope :facilities, -> { where('amenity_type > ?', 5) }
  scope :services, -> { where('amenity_type > ?', 10) }
  scope :not_included, -> { where('amenity_type > ?', 12) }
end
