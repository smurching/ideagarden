class PrivateMessage < ActiveRecord::Base
  attr_accessible :body, :recipient_id, :user_id #other attributes: :active, etc.
  belongs_to :user #belongs to its sender
  
end
