class RemakeResetCodeinUsers < ActiveRecord::Migration
  def up
    add_column :users, :reset_code, :string
    add_column :users, :reset_code_timestamp, :datetime
    
  end

  def down
    remove_column :users, :reset_code
    remove_column :users, :reset_code_timestamp
  end
end
