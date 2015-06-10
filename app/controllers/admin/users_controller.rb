class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_admin!

  layout "admin/application"

  def index
    @users = User.paginate page: params[:page], per_page: Settings.page_size
  end

  def show
    @user = User.find id: params[:id]
  end
end
