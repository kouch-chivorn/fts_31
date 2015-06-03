class Admins::SessionsController < Devise::SessionsController
  layout "admins/application"
  
  def create
    super
    # redirect_to admins_root_path
  end 
end
