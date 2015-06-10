class Admin::AdminsController < Admin::BaseController

  def show
    @admin = Admin.find params[:id]
    redirect_to admin_root_path, 
      alert: "Not found user with #{params[:id]}" unless @admin
  end
end
