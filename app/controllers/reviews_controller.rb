# frozen_string_literal: true

# This class contains reviews controller logic
class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: %i[edit update destroy]

  def index
    @reviews = review.all
  end

  def new
    @review = review.new
  end

  def create
    @review = review.new(review_params)

    if @review.save
      redirect_to reviews_path, notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
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
    @review = review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:review_type, :description)
  end
end
