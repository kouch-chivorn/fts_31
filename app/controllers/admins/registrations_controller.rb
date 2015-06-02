class Admins::RegistrationsController < ApplicationController
  layout "admins/application"

  def create
    redirect_to admins_root_path
  end
end
