class Admins::UsersController < ApplicationController
  layout "admins/application"

  def index
    @users = User.paginate page: params[:page], per_page: 10
  end

  def show
    @user = User.find id: params[:id]
  end
end
