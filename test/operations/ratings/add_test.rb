# frozen_string_literal: true

require "test_helper"

class Ratings::AddTest < ActiveSupport::TestCase
  test "should rate only once" do
    post_id = posts(:golang_post).id
    user_id = users(:john_user).id

    threads = []
    threads << Thread.new { Ratings::Add.call({ post_id:, user_id:, value: 2 }) }
    threads << Thread.new { Ratings::Add.call({ post_id:, user_id:, value: 5 }) }

    assert_difference "Rating.count" do
      threads.each(&:join)
    end

    assert_equal 2, Rating.last.value
  end
end
