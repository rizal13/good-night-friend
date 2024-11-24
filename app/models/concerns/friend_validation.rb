module FriendValidation
  extend ActiveSupport::Concern

  included do
    validates :user_id, uniqueness: { scope: :friend_id, message: "already has this friend" }
    validate :user_cannot_be_friend_of_themselves
  end

  private

  def user_cannot_be_friend_of_themselves
    errors.add(:friend_id, "can't be the same as user_id") if user_id == friend_id
  end
end
