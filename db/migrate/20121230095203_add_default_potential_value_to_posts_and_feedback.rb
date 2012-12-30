class AddDefaultPotentialValueToPostsAndFeedback < ActiveRecord::Migration
  def change
    remove_column :idea_postings, :potential
    remove_column :feedbacks, :help
    add_column :idea_postings, :potential, :integer, :default => 0
    add_column :feedbacks, :help, :integer, :default => 0
    
  end
end
