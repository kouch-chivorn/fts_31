class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
      redirect_to root_path, 
      alert: "Not found user with #{params[:id]}" unless @user
  end
end
