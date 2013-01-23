class AddPostingVotesToUser < ActiveRecord::Migration
  def change
    unless column_exists? :users, :integer
      add_column :users, :posting_votes, :string         
    end 
  end
end
