class AddActiveToPrivateMessages < ActiveRecord::Migration
  def change
    
    unless column_exists? :private_messages, :active
      add_column :private_messages, :active, :boolean, :default => true
    end
    
    unless column_exists? :private_messages, :recipient_id
      add_column :private_messages, :recipient_id, :integer
    end
    
  end
end
