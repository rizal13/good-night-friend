class Friend < ApplicationRecord
  belongs_to :follower_user, class_name: "User", foreign_key: "user_id"
  belongs_to :following_user, class_name: "User", foreign_key: "friend_id"
end
