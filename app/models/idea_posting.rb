class IdeaPosting < ActiveRecord::Base
  attr_accessible :name, :pitch, :description, :user_id
  # validates :tags, :format => {:in => %w(technology, art, music, biology, chemistry, physics, math, science, english, literature,foreign language)}
  validates :pitch, :length => {:within => 10..110}
  validates :name, :length => {:within => 10..50}  
  validates :description, :length => {:minimum => 10}  
  has_and_belongs_to_many :users, :uniq => true
  has_many :feedbacks
  has_many :joinrequests
  has_many :tags
  accepts_nested_attributes_for :tags
  
  
  scope :desc, order("idea_postings.potential DESC")

  def build_joinrequest
    self.joinrequests << Joinrequest.new()
  end
end