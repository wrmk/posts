# frozen_string_literal: true

require "test_helper"

class API::V1::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should create post" do
    assert_difference "Post.count" => 1, "User.count" => 1 do
      post api_v1_posts_path,
           params: { post: { title: "Title", body: "Body", ip: "1.1.1.1", login: "login" } }
    end

    assert_response :created

    json = response.parsed_body

    assert_predicate json["post"], :present?
    assert_predicate json["user"], :present?
  end

  test "should return error if login is blank" do
    assert_no_difference ["Post.count", "User.count"] do
      post api_v1_posts_path,
           params: { post: { title: "Title", body: "Body", ip: "1.1.1.1" } }
    end

    assert_response :unprocessable_entity

    assert_equal "can't be blank", response.parsed_body["errors"]["login"].first
  end

  test "should return error if title is blank" do
    assert_no_difference ["Post.count", "User.count"] do
      post api_v1_posts_path,
           params: { post: { body: "Body", ip: "1.1.1.1", login: "login" } }
    end

    assert_response :unprocessable_entity

    assert_equal "can't be blank", response.parsed_body["errors"]["title"].first
  end

  test "should retrieve top posts" do
    get top_posts_api_v1_posts_path(limit: 5)

    assert_response :ok

    assert_predicate response.parsed_body["posts"], :present?

    post = response.parsed_body["posts"].first

    assert_equal %w[id title body], post.keys
  end
end
