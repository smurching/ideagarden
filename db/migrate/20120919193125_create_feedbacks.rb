class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :idea_posting_id
      t.integer :user_id
      t.string :name
      t.string :body

      t.timestamps
    end
  end
end
