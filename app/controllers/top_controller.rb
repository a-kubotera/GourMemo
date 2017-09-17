class TopController < ApplicationController
  def index
    @users = User.all
  end
end
