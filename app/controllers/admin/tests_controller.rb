class Admin::TestsController < Admin::BaseController

  def index
    @search = Test.search params[:q]
    @tests = @search.result
  end

  def destroy
    test = Test.find params[:id]
    test.destroy
    flash[:success] = t("test.deleted")
    redirect_to admin_tests_path
  end
end
