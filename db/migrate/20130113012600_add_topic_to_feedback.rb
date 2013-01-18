class AddTopicToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :topic, :boolean, :default => false
  end
end
