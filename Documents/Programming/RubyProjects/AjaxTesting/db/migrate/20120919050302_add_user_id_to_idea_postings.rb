class AddUserIdToIdeaPostings < ActiveRecord::Migration
  def change
    add_column :idea_postings, :user_id, :integer
  end
end
