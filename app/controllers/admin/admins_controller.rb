class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin_admin!
  
  layout "admin/application"

  def show
    @admin = Admin.find params[:id]
    redirect_to admin_root_path, 
      alert: "Not found user with #{params[:id]}" unless @admin
  end
end
