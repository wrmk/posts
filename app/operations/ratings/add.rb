# frozen_string_literal: true

module Ratings::Add
  def self.call(rating_params)
    rating = Rating.new(rating_params)
    rating.save
    rating
  rescue ActiveRecord::RecordNotUnique
    rating.errors.add(:base, "can't be created twice")
    rating
  end
end
