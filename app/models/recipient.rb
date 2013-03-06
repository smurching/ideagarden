class Recipient < ActiveRecord::Base
  has_one :user
  has_one :private_message
end
