class AddFieldsToPrivateMessages < ActiveRecord::Migration
  def change
    unless column_exists? :private_messages, :body
      add_column :private_messages, :body, :text
    end
    unless column_exists? :private_messages, :user_id
      add_column :private_messages, :user_id, :integer
    end
    
    # to get private messages for each user, can do private_message.where(:recipient_id => desired_user_id)
    # potential problems - hacker could alter recipient or sender id of a message unless it's protected
    # no issue with protecting sender id - can just be current user's idea
    # has many recipients through user, has one sender through user
  end
end
