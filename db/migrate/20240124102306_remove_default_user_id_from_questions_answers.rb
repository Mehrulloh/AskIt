class RemoveDefaultUserIdFromQuestionsAnswers < ActiveRecord::Migration[7.1]
<<<<<<< HEAD
  # def up
  #   change_column_default :questions, :user_id, from: User.first.id, to: nil
  #   change_column_default :answers, :user_id, from: User.first.id, to: nil
  # end
  #
  # def down
  #   change_column_default :questions, :user_id, from: nil, to: User.first.id
  #   change_column_default :answers, :user_id, from: nil, to: User.first.id
  # end
=======
  def change
    return unless User.all.any?
      change_column_default :questions, :user_id, from: User.first.id, to: nil
      change_column_default :answers, :user_id, from: User.first.id, to: nil
  end
>>>>>>> ab298280d8e1e559a1f7611cec2d245679d4bc57
end
