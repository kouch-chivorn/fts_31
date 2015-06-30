class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, except: [:new, :index, :create]

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.page_size
  end

  def new
    @category = Category.new
  end

  def show
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.message.notice",
        category: @category.name
      redirect_to admin_categories_path
    else
      flash[:danger] = t "category.message.create_failed",
        category: @category.name
      render "new"
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = t "category.message.deleted"
    redirect_to admin_categories_path
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "category.message.notice",
        category: @category.name
      redirect_to admin_categories_path
    else
      flash[:danger] = t "category.message.update_failed",
        category: @category.name
      render "edit"
    end
  end

  private
  def set_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit :name, :description, :duration
  end
end
