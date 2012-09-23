class RemoveUserIdFromIdeaPostings < ActiveRecord::Migration
  def up
    remove_column :idea_postings, :user_id
  end

  def down
    add_column :idea_postings, :user_id, :integer
  end
end
