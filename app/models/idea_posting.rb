class IdeaPosting < ActiveRecord::Base
  attr_accessible :name, :pitch, :description, :tags, :user_id, :potential, :tags_attributes
  # validates :tags, :format => {:in => %w(technology, art, music, biology, chemistry, physics, math, science, english, literature,foreign language)}

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