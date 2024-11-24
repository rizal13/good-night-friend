require "test_helper"

class SleepRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get self sleep last week records" do
    user_a = users(:user_a)

    get self_sleep_records_url(user_id: user_a.id)
    assert_response :success

    json_response = JSON.parse(response.body).with_indifferent_access
    assert_equal 2, json_response[:data].length
    assert_equal "User A", json_response[:data].first[:user_name]
  end

  test "should get following sleep last week records" do
    user_a = users(:user_a)
    user_b = users(:user_b)

    # Create follow relationship
    new_friend = Friend.new(follower_user: user_a, following_user: user_b)
    user_a.following << new_friend

    get following_sleep_records_url(user_id: user_a.id)
    assert_response :success

    json_response = JSON.parse(response.body).with_indifferent_access
    assert_equal 1, json_response[:data].length
    assert_equal "User B", json_response[:data].first[:user_name]
  end

  test "should get follower sleep last week records" do
    user_a = users(:user_a)
    user_b = users(:user_b)

    # Create follow relationship
    new_friend = Friend.new(follower_user: user_a, following_user: user_b)
    user_a.following << new_friend

    get follower_sleep_records_url(user_id: user_b.id)
    assert_response :success

    json_response = JSON.parse(response.body).with_indifferent_access
    assert_equal 2, json_response[:data].length
    assert_equal "User A", json_response[:data].first[:user_name]
  end

  test "should clock in successfully and return all clockin times" do
    user_a = users(:user_a)

    post clock_in_sleep_records_url(user_id: user_a.id)
    assert_response :success

    json_response = JSON.parse(response.body).with_indifferent_access
    assert_equal 4, json_response[:data].length
  end

  test "should clock out successfully" do
    sleep_record = sleep_records(:sleep_record_a_3)

    patch clock_out_sleep_records_url(id: sleep_record.id)
    assert_response :success

    json_response = JSON.parse(response.body).with_indifferent_access
    assert_equal sleep_record.id, json_response[:data][:id]
  end

  test "should clock out return not found" do
    patch clock_out_sleep_records_url(id: 100)
    assert_response :not_found
  end

  test "should clock out return unprocessable" do
    sleep_record = sleep_records(:sleep_record_a_1)

    patch clock_out_sleep_records_url(id: sleep_record.id)
    assert_response :unprocessable_entity
  end
end
