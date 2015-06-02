class Admins::UsersController < ApplicationController
  layout "admins/application"

  def index
    @users = User.paginate page: params[:page], per_page: Settings.page_size
  end

  def show
    @user = User.find id: params[:id]
  end
end
