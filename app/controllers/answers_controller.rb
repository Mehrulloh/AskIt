class AnswersController < ApplicationController
  include QuestionsAnswers
  include ActionView::RecordIdentifier

  before_action :set_question!
  before_action :set_answer!, except: :create
  before_action :authorize_answer!
  after_action :verify_authorized

  def create
    @answer = @question.answers.build(answer_params.merge(user: current_user))
    if @answer.save
      set_respond_to question_path(@question),
                     'Answer created!',
                     query_decorate: true
    else
      load_questions_answers do_render: true
    end
  end

  def destroy
    @answer.destroy
    set_respond_to [ question_path(@question), status: :see_other ], 'Answer deleted!'
  end

  def edit; end

  def update
    if @answer.update answer_params
      set_respond_to question_path(@question, anchor: dom_id(@answer)),
                     'Answer updated',
                     query_decorate: true
    else
      render :edit
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question!
    @question = Question.find(params[:question_id])
  end

  def set_answer!
    @answer = @question.answers.find(params[:id])
  end

  def authorize_answer!
    authorize(@answer || Answer)
  end
end
