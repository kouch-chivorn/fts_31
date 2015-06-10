class Admin::Admins::SessionsController < Devise::SessionsController
  layout "admin/application"
  
  def create
    super
  end
end
