class IdeaPosting < ActiveRecord::Base

  # validates :tags, :format => {:in => %w(technology, art, music, biology, chemistry, physics, math, science, english, literature,foreign language)}
  attr_accessible :name, :pitch, :description, :user_id, :potential, :state, :photo
  validates :pitch, :length => {:within => 10..110}
  validates :name, :length => {:within => 10..50}  
  validates :description, :length => {:minimum => 10}  
  
  
  has_and_belongs_to_many :users, :uniq => true
  has_many :feedbacks
  has_many :joinrequests
  has_many :tags
  has_attached_file :photo, styles: { small: "130x130>", thumb: "45x45>" }  
  
  accepts_nested_attributes_for :tags
  
  
  scope :desc, order("idea_postings.potential DESC")

  def build_joinrequest
    self.joinrequests << Joinrequest.new()
  end
  
  def private_feedbacks
    private_feedbacks = []
    for feedback in self.feedbacks
      if feedback.private
        private_feedbacks << feedback
      end 
    end
    return private_feedbacks
  end
  
  def public_feedbacks
    public_feedbacks = []
    for feedback in self.feedbacks
      unless feedback.private
        public_feedbacks << feedback
      end 
    end
    return public_feedbacks
  end
  
  def upvote
    votes = potential
    update_attributes(potential: votes+=1)
  end

  def unvote
    votes = potential
    update_attributes(potential: votes-=1)
  end
  
  def self.search_hash
      search_hash = {"technology" => "technology", "science" => "science & math", "art"=>"art", "language" => "language",
      "community_service" => "community service", "research" => "research", 
      "making_things" => "making things", "followed_users" => "followed_users", "followers" => "followers"}
  end
  
  def self.tags
      tags = ["technology", "science & math", "art", "language", "community service", "research", "making things"]
  end
  
  def matches_query?(query)
        query_instance = Array.new(query)
        for tag in self.tags
          if query_instance.index(tag.value) != nil
            query_instance.delete(tag.value)    
          end
          if query_instance == []
            return true
          end
        end
        return false
  end
  
 def photo_url(style=:original)
    original = photo.url
    styles_hash = {:thumb => "thumb", :medium => "medium", :original => "original"}
    
    # modify so that domain name of file src attribute is correct
    modified = original.split("s3").insert(1, "s3-us-west-2").join
    
    # modify so that file is sized properly
    final = modified.split("original").insert(1, styles_hash[style]).join   
    
    if Rails.env == "development"
      return original
    end
    
    if photo_content_type["image"] != nil
      return final
    else
      return modified
    end
  end  

end