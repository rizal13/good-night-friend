class FriendsController < ApplicationController
  def create
    return render_api(:unprocessable_entity, new_friend.errors.full_messages.first) unless new_friend.save

    render_api(:created, "ok", new_friend)
  end

  def destroy
    return render_api(:not_found, "User or friend not found") unless exist_friend

    render_api(:ok, "Unfollowed successfully") if exist_friend.destroy
  end

  private

  def new_friend
    @new_friend ||= Friend.new(user_id: params[:user_id], friend_id: params[:friend_id])
  end

  def exist_friend
    @exist_friend ||= Friend.find_by(user_id: params[:id], friend_id: params[:friend_id])
  end
end
