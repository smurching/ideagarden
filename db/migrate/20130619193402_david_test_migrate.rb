class DavidTestMigrate < ActiveRecord::Migration
  def change
    add_column :idea_postings, :state, :boolean, :default => false
  end
end