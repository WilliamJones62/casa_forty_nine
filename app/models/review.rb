class Review < ApplicationRecord
    validates_presence_of :title
    validates_presence_of :body
    validates_presence_of :rating
    validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true }

    belongs_to :reviewable, polymorphic: true, counter_cache: true

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
        update_reviewable(reviewable)
    end

    def update_average_rating_for_destroyed_reviews
        @reviewable.total_rating -= @rating
        update_reviewable(@reviewable)
    end

    def update_average_rating_for_new_reviews
        reviewable.total_rating ? reviewable.total_rating += rating : reviewable.total_rating = rating
        
        update_reviewable(reviewable)
    end

    def update_reviewable(reviewable)
        reviewable.reviews_count == 0 ? reviewable.average_rating = 0 : reviewable.average_rating = (reviewable.total_rating.to_f / reviewable.reviews_count).round(2)
        reviewable.save
    end

end