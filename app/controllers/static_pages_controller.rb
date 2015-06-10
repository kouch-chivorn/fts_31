class StaticPagesController < ApplicationController
  def home
    if admin_admin_signed_in? 
      redirect_to admin_root_path 
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
