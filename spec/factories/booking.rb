# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    # want to test using the next whole month in the future
    association :user
    trait :overlap_start_of_month do
      start_date { Date.today.at_beginning_of_month.next_month - 2.days }
      end_date { Date.today.at_beginning_of_month.next_month + 3.days }
    end
    trait :overlap_end_of_month do
      start_date { Date.today.at_beginning_of_month.next_month + 27.days }
      end_date { Date.today.at_beginning_of_month.next_month.next_month + 3.days }
    end
    trait :middle_of_month do
      start_date { Date.today.at_beginning_of_month.next_month + 10.days }
      end_date { Date.today.at_beginning_of_month.next_month + 15.days }
    end
  end
end
