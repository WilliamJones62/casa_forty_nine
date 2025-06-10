# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    property_id { @property }
    user_id { @user }

    trait :far_past do
      start_date { Date.today - 16.days }
      end_date { Date.today - 8.days }
    end
    trait :past do
      start_date { Date.today - 6.days }
      end_date { Date.today - 2.days }
    end
    trait :current do
      start_date { Date.today - 1.day }
      end_date { Date.today + 3.days }
    end
    trait :future do
      start_date { Date.today + 6.days }
      end_date { Date.today + 10.days }
    end
    trait :far_future do
      start_date { Date.today + 11.days }
      end_date { Date.today + 16.days }
    end
  end
end
