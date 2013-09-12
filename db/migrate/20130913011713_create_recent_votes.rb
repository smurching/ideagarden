class CreateRecentVotes < ActiveRecord::Migration
  def change
    create_table :recent_votes do |t|
      t.integer :idea_posting_id
      t.boolean :is_upvote
      t.timestamps
    end
  end
end
