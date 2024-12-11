# frozen_string_literal: true

require "test_helper"

class API::V1::RatingsControllerTest < ActionDispatch::IntegrationTest
  test "should rate post" do
    post = posts(:golang_post)
    user = users(:john_user)

    assert_difference "Rating.count" do
      post api_v1_ratings_path,
           params: { rating: { post_id: post.id, user_id: user.id, value: 5 } }
    end

    assert_response :created

    assert_predicate response.parsed_body["average_rating"], :present?
  end

  test "should return error if post did not find when we try to rate him" do
    user = users(:john_user)

    assert_no_difference "Rating.count" do
      post api_v1_ratings_path,
           params: { rating: { post_id: 999, user_id: user.id, value: 5 } }
    end

    assert_response :unprocessable_entity

    assert_equal "must exist", response.parsed_body["errors"]["post"].first
  end

  test "should rate only once" do
    post_id = posts(:golang_post).id
    user_id = users(:john_user).id

    assert_difference "Rating.count" do
      post api_v1_ratings_path,
           params: { rating: { post_id:, user_id:, value: 2 } }
    end

    assert_response :created

    assert_no_difference "Rating.count" do
      post api_v1_ratings_path,
           params: { rating: { post_id:, user_id:, value: 5 } }
    end

    assert_response :unprocessable_entity

    assert_equal "can't be created twice", response.parsed_body["errors"]["base"].first
  end
end
