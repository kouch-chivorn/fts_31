class UsersController < ApplicationController
  before_action :authenticate_user!, except: :new
  
  def show
    @user = User.find_by id: params[:id]
    redirect_to root_path, 
      alert: "Not found user with #{params[:id]}" unless @user
  end
end
