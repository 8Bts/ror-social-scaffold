class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      flash[:notice] = 'friend request has been sent'
      redirect_to users_path
    else
      flash[:alert] = 'somethings went wrong'
      render users_path
    end
  end

  def update
    friend = User.find(params[:id])

    if current_user.confirm_friendship(friend)
      flash[:notice] = "now  you are friend with #{friend.name}"
      redirect_to users_path
    else
      flash[:notice] = 'something went wrong'
      render users_path
    end
  end

  def destroy
    friend = User.find(params[:id])

    friendship = Friendship.find_by(friend_id: friend.id, user_id: current_user.id)

    friendship&.destroy

    friendship_inverse = Friendship.find_by(friend_id: current_user.id, user_id: friend.id)

    friendship_inverse&.destroy

    flash[:notice] = "you unfriended #{friend.name}"
    redirect_to users_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
