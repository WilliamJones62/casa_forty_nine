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

  factory(:user) do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    trait :admin do
      admin { true }
    end
    # user_with_middle_bookings will create mid-month booking data after the user has been created
    factory :user_with_middle_bookings do
      # bookings_count is declared as a transient attribute available in the
      # callback via the context
      transient do
        bookings_count { 1 }
      end

      # the after(:create) yields two values; the user instance itself and the
      # context, which stores all values from the factory, including transient
      # attributes; `create_list` second argument is the number of records
      # to create and we make sure the user is associated properly to the booking
      after(:create) do |user, context|
        create_list(:booking, context.bookings_count, :middle_of_month, user: user)

        # You may need to reload the record here, depending on your application
        user.reload
      end
    end
    # user_with_start_bookings will create start month booking data after the user has been created
    factory :user_with_start_bookings do
      # bookings_count is declared as a transient attribute available in the
      # callback via the context
      transient do
        bookings_count { 1 }
      end

      # the after(:create) yields two values; the user instance itself and the
      # context, which stores all values from the factory, including transient
      # attributes; `create_list` second argument is the number of records
      # to create and we make sure the user is associated properly to the booking
      after(:create) do |user, context|
        create_list(:booking, context.bookings_count, :overlap_start_of_month, user: user)

        # You may need to reload the record here, depending on your application
        user.reload
      end
    end
    # user_with_end_bookings will create end month booking data after the user has been created
    factory :user_with_end_bookings do
      # bookings_count is declared as a transient attribute available in the
      # callback via the context
      transient do
        bookings_count { 1 }
      end

      # the after(:create) yields two values; the user instance itself and the
      # context, which stores all values from the factory, including transient
      # attributes; `create_list` second argument is the number of records
      # to create and we make sure the user is associated properly to the booking
      after(:create) do |user, context|
        create_list(:booking, context.bookings_count, :overlap_end_of_month, user: user)

        # You may need to reload the record here, depending on your application
        user.reload
      end
    end
  end
end
