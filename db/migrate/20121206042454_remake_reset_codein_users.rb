class RemakeResetCodeinUsers < ActiveRecord::Migration
  def up
    remove_column :users, :reset_code
    add_column :users, :reset_code, :string
    add_column :users, :reset_code_timestamp, :datetime
    
  end

  def down
    remove_column :users, :reset_code
    add_column :users, :reset_code, :text
    remove_column :users, :reset_code_timestamp
  end
end
