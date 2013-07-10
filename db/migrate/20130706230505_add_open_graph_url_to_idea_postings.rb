class AddOpenGraphUrlToIdeaPostings < ActiveRecord::Migration
  def change
    add_column :idea_postings, :opengraph_id, :string
  end
end
