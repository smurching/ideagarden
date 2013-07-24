class AddPhotoToIdeaPostings < ActiveRecord::Migration
  def change
    add_attachment :idea_postings, :photo
  end
end
