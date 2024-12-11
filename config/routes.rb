# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :posts, only: [:create] do
        post :rate
      end
    end
  end
end
