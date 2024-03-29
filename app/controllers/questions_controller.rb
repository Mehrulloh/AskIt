class QuestionsController < ApplicationController
  include QuestionsAnswers

  before_action :require_authentication, except: %i[show index]
  before_action :set_question!, only: %i[show edit destroy update]
  before_action :fetch_tags, only: %i[new edit]
  before_action :authorize_question!
  after_action :verify_authorized

  def index
    @pagy, @questions = pagy Question.all_by_tags(params[:tag_ids]),
                             link_extra: "data-turbo-frame=pagination"
    @questions = @questions.decorate
  end

  def show
    load_questions_answers
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build question_params

    if @question.save
      set_respond_to questions_path, (t ".success"),
                     query_decorate: true
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update question_params
      set_respond_to questions_path, (t ".success"),
                                    query_decorate:true
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit; end

  def destroy
    @question.destroy
    set_respond_to [questions_path, status: :see_other],
                   (t ".deleted")
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    @question = Question.find(params[:id])
  end

  def fetch_tags
    @tags = Tag.all
  end

  def authorize_question!
    authorize(@question || Question)
  end
end
