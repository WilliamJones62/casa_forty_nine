FactoryBot.define do
  factory :review do
    title { "Good review" }
    body { "This place is great!" }
    rating { 5 }
    trait :for_property do
      association :reviewable, factory: :property
    end
  end
end
