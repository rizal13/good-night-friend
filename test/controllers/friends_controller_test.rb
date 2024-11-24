require "test_helper"

class FriendsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = users(:user_a)
    @user_b = users(:user_b)
    @user_c = users(:user_c)
  end

  test "should create a follow friend relationship" do
    assert_difference("Friend.count", 1) do
      post friends_url, params: { user_id: @user_a.id, friend_id: @user_c.id }
    end
    assert_response :created

    json_response = JSON.parse(response.body).with_indifferent_access
    assert_equal @user_a.id, json_response[:data][:follower_user_id]
    assert_equal @user_c.id, json_response[:data][:following_user_id]
  end

  test "should not create a duplicate follow relationship" do
    assert_no_difference("Friend.count") do
      post friends_url, params: { user_id: @user_a.id, friend_id: @user_b.id }
    end
    assert_response :unprocessable_entity

    json_response = JSON.parse(response.body).with_indifferent_access
    assert_includes json_response["message"], "User already has this friend"
  end

  test "should destroy a friend follow relationship" do
    assert_difference("Friend.count", -1) do
      delete friend_url(id: @user_a.id), params: { friend_id: @user_b.id }
    end
    assert_response :ok

    json_response = JSON.parse(response.body).with_indifferent_access
    assert_equal "Unfollowed successfully", json_response["message"]
  end
end
