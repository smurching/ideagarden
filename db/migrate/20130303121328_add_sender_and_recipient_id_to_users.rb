class AddSenderAndRecipientIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sender_id, :integer
    add_column :users, :recipient_id, :integer
  end
end
