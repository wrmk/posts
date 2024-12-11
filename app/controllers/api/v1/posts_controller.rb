# frozen_string_literal: true

class API::V1::PostsController < ApplicationController
  def create
    post = Posts::Add.call(post_params:, user_params:)

    if post.errors.present?
      render json: { errors: post.errors }, status: :unprocessable_entity
    else
      render json: { post:, user: post.user }, status: :created
    end
  end

  def rate
    rate = Ratings::Add.call(rating_params)

    if rate.errors.present?
      render json: { errors: rate.errors }, status: :unprocessable_entity
    else
      render json: { average_rating: rate.post.average_rating }, status: :created
    end
  end

  def top_posts
    posts = Posts::Top.call(params[:limit].to_i)

    render json: { posts: }, status: :ok
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :ip).to_h
  end

  def user_params
    params.require(:post).permit(:login).to_h
  end

  def rating_params
    params.require(:rating).permit(:post_id, :user_id, :value).to_h
  end
end
