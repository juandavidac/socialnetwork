class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create]

  def create
    @friendship = current_user.request_friendships(@user)
    respond_to do |format|
      format.html {redirect_to users_path, notice: "Friendship created"}
    end
  end

  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html {redirect_to users_path, notice: "Friendship deleted"}
    end
  end

  def accept
    @friendship.accept_friendship
    @friendship.create_activity key: 'friendship.accepted', owner: @friendship.user, recipient: @friendship.friend
    @friendship.create_activity key: 'friendship.accepted', owner: @friendship.friend, recipient: @friendship.owner
    respond_to do |format|
      format.html {redirect_to users_path, notice: "Friendship accepted"}
    end
  end

  def show
    @activities= PublicActivity::Activity.where(owner_id: @user.id)
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end
end
