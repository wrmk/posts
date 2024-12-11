# frozen_string_literal: true

class API::V1::UsersController < ApplicationController
  def top_authors
    authors = Users::FirstWithIP.call(params[:limit].to_i)

    render json: { authors: }, status: :ok
  end
end
