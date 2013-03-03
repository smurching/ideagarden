class AddColumnsToPms < ActiveRecord::Migration
  def change
    add_column :private_messages, :user_id, :integer
    add_column :private_messages, :body, :text
    add_column :private_messages, :recipient_id, :integer
  end
end
