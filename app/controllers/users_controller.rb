class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @follow = @user.followers
    @followed = @user.followed_users
  end
end
