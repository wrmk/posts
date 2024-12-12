# frozen_string_literal: true

class API::V1::UsersController < ApplicationController
  def list_with_ip
    authors = Users::ListWithIP.call(params[:limit].to_i)

    render json: { authors: }, status: :ok
  end
end
