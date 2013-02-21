class AddConfirmedToUsers < ActiveRecord::Migration
  def change
    unless column_exists? :users, :confirmed
      add_column :users, :confirmed, :boolean, :default => false
    end
  end
end
