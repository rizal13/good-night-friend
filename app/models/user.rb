class User < ApplicationRecord
  has_many :sleep_records, dependent: :destroy
  has_many :followers, class_name: "Friend", foreign_key: :friend_id, dependent: :destroy
  has_many :following, class_name: "Friend", foreign_key: :user_id, dependent: :destroy
end
