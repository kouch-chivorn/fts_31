class TestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test,only: [:show, :edit, :update]
  def index
    @test = Test.new
    @tests = current_user.tests
      .order("created_at DESC")
      .paginate page: params[:page], per_page: Settings.page_size
  end

  def new
    @test = Test.new
  end

  def show
    @i = 0
  end

  def create
    category = Category.find params[:test][:category_id]
    test = category.tests.build
    test.user_id = current_user.id
    test.status = Settings.status.start
    if test.save
      flash[:success] = t("test.created")
      redirect_to tests_path
    else
      render :new
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
    if @test.update_attributes test_question_params
      @test.update_attributes status: Settings.status.view
      flash[:success] = t("flash.answer_update")
      redirect_to test_path @test
    else
      redirect_to :back
    end
  end


  private
  def test_question_params
    params.require(:test).permit test_questions_attributes: [:id, :answer_id]
  end

  def set_test
    @test = Test.find params[:id]
  end
end
