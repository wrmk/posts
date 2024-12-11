# frozen_string_literal: true

require "test_helper"

class Posts::AddTest < ActiveSupport::TestCase
  test "should create user only once" do
    user_params = { login: "user" }
    post_params = { title: "title", body: "body", ip: "1.1.1.1" }

    assert_difference "User.count" => 1, "Post.count" => 1 do
      Posts::Add.call(post_params:, user_params:)
    end

    assert_no_difference "User.count" do
      assert_difference "Post.count" do
        Posts::Add.call(post_params:, user_params:)
      end
    end
  end
end
