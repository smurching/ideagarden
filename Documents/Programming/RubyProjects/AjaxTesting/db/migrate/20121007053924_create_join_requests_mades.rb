class CreateJoinRequestsMades < ActiveRecord::Migration
  def change
    create_table :join_requests_mades do |t|
      t.integer :idea_posting_id

      t.timestamps
    end
  end
end
