class Property < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :headline
    validates_presence_of :description
    validates_presence_of :address
    validates_presence_of :city
    validates_presence_of :state
    validates_presence_of :country

    monetize :price_cents, allow_nil: true

    has_many_attached :images, dependent: :destroy
    has_many :reviews, as: :reviewable

end
