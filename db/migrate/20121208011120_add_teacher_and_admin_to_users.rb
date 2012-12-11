class AddTeacherAndAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :teacher, :boolean, :default => false
  end
end
