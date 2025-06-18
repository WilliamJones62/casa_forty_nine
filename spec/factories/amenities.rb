# frozen_string_literal: true

FactoryBot.define do
  factory :amenity do
    amenity_type { 1 }
    description { 'MyString' }
  end
end
