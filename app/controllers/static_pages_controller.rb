class StaticPagesController < ApplicationController
  def home
    redirect_to admins_root_path if admin_signed_in?
  end

  def help
  end

  def contact
  end

  def about
  end

  def news
  end
end
