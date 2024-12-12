# frozen_string_literal: true

require "test_helper"

class API::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should return top authors" do
    get list_with_ip_api_v1_users_path, params: { limit: 5 }

    assert_response :success

    assert_predicate response.parsed_body["authors"], :present?
  end
end
