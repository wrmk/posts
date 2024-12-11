# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :posts, only: [:create] do
        get :top_posts
      end

      resource :ratings, only: [:create]

      resource :users, only: [] do
        get :top_authors
      end
    end
  end
end
