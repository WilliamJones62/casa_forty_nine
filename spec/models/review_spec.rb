# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe Review, type: :model do
  before(:context) do
    @property = create(:property)
    @review = create(:review, reviewable: @property)
  end

  describe 'reviews' do
    it 'updates the property when a review is created' do
      expect(@property.reviews_count).to eq(1)
      expect(@property.average_rating).to eq(5)
      expect(@property.total_rating).to eq(5)
    end

    it 'updates the property when a second review is created' do
      review2 = create(:review, reviewable: @property)
      review2.rating = 1
      review2.save
      expect(@property.reviews_count).to eq(2)
      expect(@property.average_rating).to eq(3)
      expect(@property.total_rating).to eq(6)
    end

    it 'updates the property when a review is updated' do
      @review.rating = 3
      @review.save
      expect(@property.reviews_count).to eq(2)
      expect(@property.average_rating).to eq(2)
      expect(@property.total_rating).to eq(4)
    end

    it 'updates the property when a review is destroyed' do
      @review.destroy
      expect(@property.reviews_count).to eq(1)
      expect(@property.average_rating).to eq(1)
      expect(@property.total_rating).to eq(1)
    end
  end
end

# rubocop:enable Metrics/BlockLength
