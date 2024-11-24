class FriendRelationSerializer < ActiveModel::Serializer
  attributes :id, :following_user_id, :follower_user_id

  def following_user_id
    object.friend_id
  end

  def follower_user_id
    object.user_id
  end
end
