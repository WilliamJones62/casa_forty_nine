# frozen_string_literal: true

# This class contains User model logic
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :reserved_properties, through: :reservations, source: :property
  has_one_attached :image, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}".squish
  end
end
