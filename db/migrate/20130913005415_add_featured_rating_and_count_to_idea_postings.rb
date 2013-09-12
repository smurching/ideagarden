class AddFeaturedRatingAndCountToIdeaPostings < ActiveRecord::Migration
  def change
    add_column :idea_postings, :featured_rating, :float, :default => 0
    add_column :idea_postings, :featured_count, :integer, :default => 0
    add_column :idea_postings, :featured, :boolean, :default => false
    
  end
end
