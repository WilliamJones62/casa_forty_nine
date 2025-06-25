# frozen_string_literal: true

# This class contains Review model logic
class Review < ApplicationRecord
  STAR_COUNT_FIELDS = ['', 'star_1_count', 'star_2_count', 'star_3_count', 'star_4_count', 'star_5_count'].freeze
  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :rating
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true }

  belongs_to :reviewable, polymorphic: true, counter_cache: true
  belongs_to :user
  
  before_update :save_rating_value
  before_destroy :save_rating_value
  before_destroy :save_reviewable

  after_commit :update_average_rating_for_updated_reviews, on: [:update]
  after_commit :update_average_rating_for_destroyed_reviews, on: [:destroy]
  after_commit :update_average_rating_for_new_reviews, on: [:create]

  def save_rating_value
    @rating = rating_was
  end

  def save_reviewable
    @reviewable = reviewable
  end

  def update_average_rating_for_updated_reviews
    reviewable.total_rating -= (@rating - rating)
    reviewable[STAR_COUNT_FIELDS[@rating]] -= 1
    load_star_count
    update_reviewable(reviewable)
  end

  def update_average_rating_for_destroyed_reviews
    @reviewable.total_rating -= @rating
    @reviewable[STAR_COUNT_FIELDS[rating]] -= 1
    update_reviewable(@reviewable)
  end

  def update_average_rating_for_new_reviews
    reviewable.total_rating ? reviewable.total_rating += rating : reviewable.total_rating = rating
    load_star_count
    update_reviewable(reviewable)
  end

  def load_star_count
    if reviewable[STAR_COUNT_FIELDS[rating]]
      reviewable[STAR_COUNT_FIELDS[rating]] += 1
    else
      reviewable[STAR_COUNT_FIELDS[rating]] =
        1
    end
  end

  def update_reviewable(reviewable)
    reviewable.average_rating = if reviewable.reviews_count.zero?
                                  0
                                else
                                  (reviewable.total_rating.to_f / reviewable.reviews_count).round(2)
                                end
    reviewable.save
  end
end
