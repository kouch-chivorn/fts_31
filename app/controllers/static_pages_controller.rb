class StaticPagesController < ApplicationController
  def home
    if admin_signed_in? 
      redirect_to admins_root_path 
    else
      redirect_to tests_path if user_signed_in?
    end
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
