# frozen_string_literal: true

class API::V1::RatingsController < ApplicationController
  def create
    rate = Ratings::Add.call(rating_params)

    if rate.errors.present?
      render json: { errors: rate.errors }, status: :unprocessable_entity
    else
      render json: { average_rating: rate.post.average_rating }, status: :created
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:post_id, :user_id, :value).to_h
  end
end