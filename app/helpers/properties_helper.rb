# frozen_string_literal: true

# This module contains Property helper logic
module PropertiesHelper

  def user_address(review)
    address_fields = ['city', 'state', 'country']
    address = ''
    address_fields.each do |af|
      address += review.user[af] + ', ' if !review.user[af].blank?
    end
    address = address[0...-2] if address
    address
    # "#{review.user.city}, #{review.user.state}, #{review.user.country}"
  end

  def review_month_year(review)
    review.updated_at.strftime('%B, %Y')
  end

  def review_star_rating(review, stars)
    review.rating >= stars ? 'text-warning' : 'text-light'
  end

  def review_percentage(property, stars)
    star_count_fields = ['', 'star_1_count', 'star_2_count', 'star_3_count', 'star_4_count', 'star_5_count']
    if property[star_count_fields[stars]] && property.reviews_count > 0
      ((property[star_count_fields[stars]] / property.reviews_count.to_f) * 100).round.to_s
    else
      0
    end
  end
end
