class AddUserIdToJoinRequestsMade < ActiveRecord::Migration
  def change
    add_column :join_requests_mades, :user_id, :integer 
  end
end
