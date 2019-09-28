# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :find_film
  decorates_assigned :film

  def create
    @review = @film.reviews.create(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to film_path(@film), notice: 'Success'
    else
      render 'films/show'
    end
  end

  private

  def find_film
    @film = Film.friendly.find(params[:film_id])
  end

  def review_params
    params.require(:review).permit(:rating, :review_body, :user_id, :film_id)
  end
end
