class AddRootIdToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :root_id, :integer
  end
end
