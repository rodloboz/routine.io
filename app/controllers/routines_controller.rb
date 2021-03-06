class RoutinesController < ApplicationController
  before_action :set_routine, only: [:show, :edit, :update, :destroy, :submit, :template, :use_template]

  def index
    @routines = policy_scope(Routine)
  end

  def new
    @routine = Routine.new
    authorize @routine
  end

  def create
    @routine = current_user.routines.new(routine_params)
    authorize @routine
    if @routine.save
      redirect_to routine_editor_path(@routine)
    else
      render :new
    end
  end

  def show
    authorize @routine
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def submit
    @answer = @routine.today
    @routine.has_answer = true
    @routine.save
    skip_authorization if @routine.user == current_user
    redirect_to answer_fields_path(@answer)
  end

  def template
    @routine.template = true
    skip_authorization if @routine.user == current_user
    if @routine.save
      redirect_to routine_editor_path(@routine)
    else
      redirect_to root_path
    end
  end

  def use_template
    @template = Routine.find(params[:template_id])
    if @template.template
      @routine.destroy_questions
      @template.questions.each do |question|
        q = question.deep_clone include: [:question_choices]
        @routine.questions << q
      end
      @routine.save
      redirect_to routine_editor_path(@routine)
      skip_authorization
    else
      redirect_to root_path
    end
  end

  def set_routine
    @routine = Routine.find(params[:id])
  end

  def routine_params
    params.require(:routine).permit(:name)
  end
end
