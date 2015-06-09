class Admins::QuestionsController < ApplicationController
  before_action :authenticate_admin!, :set_category
  before_action :set_question, except: [:index, :new, :create]

  layout "admins/application"
  
  def index
    @questions = Question.paginate page: params[:page], 
      per_page: Settings.page_size
  end

  def new
    @question = Question.new
    4.times { @question.answers.build}
  end

  def create
    @question = Question.new question_params
    @question.category = @category
    if @question.save!
      flash[:notice]= t "question.message.notice", 
        question: @question.category.name
      redirect_to [:admins, @category, :questions]
    else
      render :edit
    end
  end

  def show
  end

  def edit
    @question.category = @category
  end

  def update
    if @question.update_attributes question_params
      flash[:notice] = t "question.message.notice", 
        question: @question.category.name
      redirect_to [:admins, @category, :questions]
    else
      render "edit"
    end
  end

  def destroy
    @question.destroy
    flash[:notice] = t "question.message.delete", 
      question: @question.category.name
    redirect_to [:admins, @category, :questions]
  end

  private
  def set_question
    @question = Question.find params[:id]
  end

  def set_category
    @category = Category.find params[:category_id]
  end

  def question_params
    params.require(:question).permit :content, 
      answers_attributes: [:id, :content, :correct]
  end
end
