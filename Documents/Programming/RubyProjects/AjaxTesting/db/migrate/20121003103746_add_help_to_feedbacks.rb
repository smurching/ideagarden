class AddHelpToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :help, :integer
  end
end
