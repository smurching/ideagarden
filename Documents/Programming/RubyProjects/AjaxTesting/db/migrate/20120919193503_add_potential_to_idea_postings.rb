class AddPotentialToIdeaPostings < ActiveRecord::Migration
  def change
    add_column :idea_postings, :potential, :integer
  end
end
