class AddFeedbackIdToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :feedback_id, :integer
  end
end
