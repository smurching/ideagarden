class CreateIdeaPostingsUsers < ActiveRecord::Migration
  def up
    create_table :idea_postings_users, :id => false do |t|
      t.references :idea_posting
      t.references :user
    end
  end

  def down
    drop_table :idea_postings_users
  end
end
