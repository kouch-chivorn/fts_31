class TestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test,only: [:show, :edit, :update]
  before_action :set_cache_headers, only: [:index, :edit]

  def index
    @test = Test.new
    @tests = current_user.tests
    .order("created_at DESC")
    .paginate page: params[:page], per_page: Settings.page_size
  end

  def show
    @i = 0
  end

  def create
    @test = current_user.tests.create category_id: params[:test][:category_id]
    @test.status = Settings.status.start
    if @test.save
      flash[:success] = t("test.created")
      redirect_to tests_path category_id: params[:test][:category_id]
    else
      flash[:danger] = t("test.failed")
      redirect_to tests_path
    end
  end

  def edit
    unless @test.status == Settings.status.view
      if @test.started_time.nil?
        started_time = Time.zone.now
        @test.update_attributes status: Settings.status.testing,
          started_time: started_time
      end
      @time_left = @test.category.duration * 60 - (Time.zone.now - @test.started_time).to_i
      if @time_left <= 0
        @test.update_attributes status: Settings.status.view
      end
      @i = 0
    else
      redirect_to test_path @test
    end
  end

  def update
    if !@test.result.nil? && (@test.update_attributes test_question_params)
      @test.update_attributes status: Settings.status.view
      flash[:success] = t("flash.answer_update")
      UserMailer.delay.email_result(@test.user.id)
      redirect_to test_path @test
    else
      flash[:danger] = t("test.failed")
      redirect_to :back
    end
  end

  private
  def test_question_params
    params.require(:test).permit test_questions_attributes: [:id, :answer_id]
  end

  def set_test
    @test = current_user.tests.find params[:id]
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0,
      must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "01 Jan 1990 00:00:00 GMT"
  end
end
