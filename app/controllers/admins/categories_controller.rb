class Admins::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  layout "admins/application"

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.page_size
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    
    if @category.save!
      flash[:notice] = I18n.t "category.message.notice", category: @category.name
      redirect_to admins_categories_path
    else
      render "new"
    end
  end

  def destroy
    @category = Category.find params[:id]
    @category.destroy
    redirect_to admins_categories_path
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes category_params
      redirect_to admins_subjects_path
    else
      render "edit"
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
