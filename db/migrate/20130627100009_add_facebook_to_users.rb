class AddFacebookToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook, :boolean, :default => false
  end
end
