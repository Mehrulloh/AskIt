class AnswerDecorator < ApplicationDecorator
  delegate_all
  decorates_association :user
  decorates_association :question

  def formatted_created_at
    l created_at, format: :long
  end
end
