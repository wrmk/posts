# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_many :ratings, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :ip, presence: true

  # We can't use `average` method because it makes additional SQL query even it we preload ratings
  def average_rating
    return 0.0 if ratings.empty?

    (ratings.pluck(:value).sum / ratings.size.to_f).round(2)
  end
end
