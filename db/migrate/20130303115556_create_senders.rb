class CreateSenders < ActiveRecord::Migration
  def change
    create_table :senders do |t|
      t.integer :user_id
      t.integer :private_message_id
      t.boolean :active
      t.timestamps
    
    end
  end
end
