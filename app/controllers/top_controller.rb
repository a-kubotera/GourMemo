class TopController < ApplicationController
  def index
    @users = User.all
  end

  def index2
    @user = current_user
    @page_title ='マイページ'
    #@follow = @user.followers
    #@followed = @user.followed_users
  end
end
