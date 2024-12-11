# frozen_string_literal: true

module Ratings::Add
  def self.call(rate_params)
    rate = Rating.new(rate_params)
    rate.save
    rate
  end
end
