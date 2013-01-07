class AddConfirmationCodeToUsers < ActiveRecord::Migration
  def change
    if column_exists? :users, :confirmation_code
      remove_column :users, :confirmation_code
    end
    add_column :users, :confirmation_code, :string
  end
end
