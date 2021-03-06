class QuestionsController < ApplicationController
  before_action :set_routine, except: [:use_template]
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @questions = @routine.questions.order(:position)
    @templates = Routine.templates
    skip_policy_scope if @routine.user == current_user
  end

  def new
    @question_type = QuestionType.find_by_name(params[:question_type_name])
    @question = @routine.questions.new
    @question.question_choices.build
    respond_to do |format|
      format.js
    end
  end

  def create
    @question = @routine.questions.new(question_params)
    @question.position = @routine.questions.count + 1
    respond_to do |format|
      if @question.save
        format.html { redirect_to routine_questions_path(@routine) }
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @question.update(question_params)
      @questions = @routine.questions.order(:position)
      respond_to do |format|
        format.html { redirect_to routine_questions_path(@routine) }
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @question.question_choices.destroy_all
    @question.delete
    @questions = @routine.questions
    @questions.each_with_index do |question, index|
      question.position = index + 1
      question.save
    end
  end

  def sort
    params[:order].each do |key,value|
      Question.find(value[:id]).update_attribute(:position,value[:position])
    end
    @questions = @routine.questions.order(:position)
    respond_to do |format|
      format.js
    end
  end

  def set_routine
    @routine = Routine.find(params[:routine_id])
    authorize @routine
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:name, :options, :question_type_id, question_choices_attributes: [:id, :name, :_destroy])
  end

end
