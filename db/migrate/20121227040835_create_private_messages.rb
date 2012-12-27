class CreatePrivateMessages < ActiveRecord::Migration
  def change
    create_table :private_messages do |t|

      t.timestamps
    end
  end
end
