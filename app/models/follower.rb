class Follower < ActiveRecord::Base
   attr_accessible :follower_user_id, :user_id
end
