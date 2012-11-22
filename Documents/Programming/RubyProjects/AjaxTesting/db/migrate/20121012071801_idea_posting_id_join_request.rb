class IdeaPostingIdJoinRequest < ActiveRecord::Migration
  def up
    remove_column :joinrequests, :ideapostingid
    add_column :joinrequests, :idea_posting_id, :integer
  end

  def down
    add_column :joinrequests, :ideapostingid, :integer
    remove_column :joinrequests, :idea_posting_id
  end
end
