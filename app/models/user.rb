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

  def admin?
    admin == true
  end

  def cancellable_reservations
    future_res = if admin
                   Reservation.future_reservations.all
                 else
                   reservations.future_reservations.all
                 end
    cancellable_res = []
    future_res.each { |f| cancellable_res << f if f.start_date > Date.today + f.property.cancellation_days }
    cancellable_res
  end
end
