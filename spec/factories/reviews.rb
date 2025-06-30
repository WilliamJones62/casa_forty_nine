# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    title { 'Good review' }
    body { 'This place is great!' }
    rating { 5 }
    user_id { @user }
    trait :for_property do
      association :reviewable, factory: :property
    end
  end
end
