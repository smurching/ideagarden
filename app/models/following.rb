class Following < ActiveRecord::Base
   attr_accessible :followed_user_id, :user_id
  belongs_to :user
end
