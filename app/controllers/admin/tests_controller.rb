class Admin::TestsController < Admin::BaseController

  def index
    @test = Test.new
    @tests = Test.paginate page: params[:page], per_page: Settings.page_size
  end

  def destroy
    Test.find params[:id].destroy
    flash[:success] = t("test.deleted")
    redirect_to admins_tests_path
  end
end
