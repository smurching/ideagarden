class ChangeVariableTypesOfMessageAttributesToText < ActiveRecord::Migration
  def change
    remove_column :joinrequests, :message
    remove_column :feedbacks, :body
    add_column :joinrequests, :message, :text
    add_column :feedbacks, :body, :text
  end
end
