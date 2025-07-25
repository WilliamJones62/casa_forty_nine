# frozen_string_literal: true

# This class contains reviews controller logic
class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: %i[edit update destroy]
  before_action :set_reservation, only: %i[new edit]

  def index
    @review_reservations = if current_user.admin
                             Reservation.past_reservations.order(:start_date)
                           else
                             current_user.reservations.past_reservations.order(:start_date)
                           end
  end

  def new
    @review = Review.new
  end

  def create
    load_review_data
    if @review.save
      ReviewMailer.create_review(current_user, @review).deliver_later
      redirect_to reviews_path, notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      ReviewMailer.update_review(current_user, @review).deliver_later
      redirect_to reviews_path, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_url, notice: 'Review was successfully deleted.'
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_reservation
    session[:reservation_id] = params[:reservation_id]
  end

  def load_review_data
    property = Property.first
    @review = Review.new(review_params)
    @review.reviewable = property
    @review.user_id = current_user.id
    @review.reservation_id = session[:reservation_id]
  end

  def review_params
    params.require(:review).permit(:title, :body, :rating)
  end
end
