class PrivateMessage < ActiveRecord::Base
  attr_accessible :body, :recipient_ids, :user_id, :user_tokens #other attributes: :active, etc.
  has_many :users, :through => :recipients
  has_one :user, :through => :sender
  has_one :sender
  has_many :recipients
  attr_reader :user_tokens
  
  def user_tokens=(ids)
    self.user_ids = ids.split(",")
  end
end
