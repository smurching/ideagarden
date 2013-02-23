class AddActiveToPrivateMessages < ActiveRecord::Migration
  def change
    add_column :private_messages, :active, :boolean, :default => true
    add_column :private_messages, :recipient_id, :integer
  end
end
