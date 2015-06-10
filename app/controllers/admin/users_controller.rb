class Admin::UsersController < Admin::BaseController

  def index
    @users = User.paginate page: params[:page], per_page: Settings.page_size
  end

  def show
    @user = User.find_by id: params[:id]
  end
end
