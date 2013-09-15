class CreateFeedbackVotes < ActiveRecord::Migration
  def change
    create_table :feedback_votes do |t|
      t.integer :feedback_id
      t.integer :user_id
      t.boolean :is_upvote
      
      t.timestamps
    end
  end
end
