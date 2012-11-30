class AddPrivateToFeedback < ActiveRecord::Migration
  def change
   add_column :feedbacks, :private, :boolean
  end
end
