class CreateIdeaPostings < ActiveRecord::Migration
  def change
    create_table :idea_postings do |t|

      t.string :name
      t.string :pitch
      t.text :description
      t.string :tags

      t.datetime :published_at

      t.timestamps
    end
  end
end
