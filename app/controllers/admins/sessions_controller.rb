class Admins::SessionsController < Devise::SessionsController
  layout "admins/application"

  def create
    super
  end 
end
