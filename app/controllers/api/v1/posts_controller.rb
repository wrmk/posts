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

  private

  def post_params
    params.require(:post).permit(:title, :body, :ip).to_h
  end

  def user_params
    params.require(:post).permit(:login).to_h
  end
end
