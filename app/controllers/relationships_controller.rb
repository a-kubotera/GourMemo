class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js
  #protect_from_forgery with: :exception
  #skip_before_filter :verify_authenticity_token

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_with @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end
end
