class RemoveStringTagsFromIdeaPostings < ActiveRecord::Migration
  def up
    remove_column :idea_postings, :tags
  end

  def down
    add_column :idea_postings, :tags, :string
  end
end
