class CreateJoinrequests < ActiveRecord::Migration
  def change
    create_table :joinrequests do |t|
      t.integer :userid
      t.integer :ideapostingid
      t.string :message

      t.timestamps
    end
  end
end
