# frozen_string_literal: true

require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "should correct calculate average rating" do
    post = posts(:ruby_post)
    rating1 = ratings(:ruby_post_rating_first)
    rating2 = ratings(:ruby_post_rating_second)

    assert_equal post.ratings, [rating1, rating2]
    assert_equal 5, rating1.value
    assert_equal 1, rating2.value

    assert_in_delta 3.0, post.average_rating
  end
end
