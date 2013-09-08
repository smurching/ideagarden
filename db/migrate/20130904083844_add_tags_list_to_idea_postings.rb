class AddTagsListToIdeaPostings < ActiveRecord::Migration
  def change
    create_table :tags_lists do |t|
      t.integer :idea_posting_id
      
      t.boolean :technology
      t.boolean :science_and_math
      t.boolean :art
      t.boolean :language
      
      t.boolean :community_service
      t.boolean :making_things
      t.boolean :research
      
      t.timestamps
    end
    
   drop_table :tags
  end
end
