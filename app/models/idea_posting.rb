class IdeaPosting < ActiveRecord::Base

  # validates :tags, :format => {:in => %w(technology, art, music, biology, chemistry, physics, math, science, english, literature,foreign language)}
  attr_accessible :name, :pitch, :description, :user_id, :potential, :state, :photo
  validates :pitch, :length => {:within => 10..110}
  validates :name, :length => {:within => 10..50}  
  validates :description, :length => {:minimum => 10}  
  
  
  has_and_belongs_to_many :users, :uniq => true
  has_many :feedbacks
  has_many :joinrequests
  has_one :tags_list
  has_attached_file :photo, styles: { small: "130x130>", thumb: "45x45>" }  
  
  
  
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
  
  #params contains keys, corresponding values are used to search tags table
  def self.search_hash
      search_hash = {"technology" => "technology", "science_and_math" => "science_and_math", "art"=>"art", "language" => "language",
      "community_service" => "community_service", "research" => "research", 
      "making_things" => "making_things", "followed_users" => "followed_users", "followers" => "followers"}            
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
  
  def potential_ranking
    posting_list = IdeaPosting.order("potential DESC")
    num_of_postings = posting_list.length
    percentile = 100*(num_of_postings-posting_list.index(self))/num_of_postings
    point_value = percentile/10
  end
  
  def rising_ranking
    
    vote_recipients = RecentVotes.select(:idea_posting_id).uniq.map!{ |object| object.idea_posting_id}
    
    if vote_recipients.include?(self.id)
      votes_array = []
      
      vote_recipients.each do |id|
        upvotes = RecentVotes.where("idea_posting_id = ? AND is_upvote = TRUE", id).length
        downvotes = RecentVotes.where("idea_posting_id = ? AND is_upvote = FALSE", id).length

        if (rating_change = downvotes-upvotes) > 0
          votes_array << [id, rating_change]
        end
                
      end    
      
      sorted_ids_list = votes_array.sort_by!{|element| element[1]}.map{|element| element[0]}
    
      num_of_postings = sorted_ids_list.length
      percentile = 100*(num_of_postings-sorted_ids_list.index(self.id))/num_of_postings
      point_value = percentile/10
    
    else
      return 0          
    end
  end
  
  def compute_featured_rating
    (rising_ranking + potential_ranking)/(self.featured_count+1)
  end
  
  def save_featured_rating
    self.featured_rating = self.compute_featured_rating
    self.save
  end
  
  def self.update_featured_posts(quantity = 3)
    IdeaPosting.all.each do |posting|
      if posting.featured
        posting.featured = false
        posting.featured_count += 1
      end
      posting.save_featured_rating
    end
    list = IdeaPosting.order("featured_rating DESC").slice!(0, quantity)
    list.each do |elem|
      elem.featured = true
      elem.save
    end    
  end
  
  def self.featured_posts
    IdeaPosting.where("featured = TRUE")
  end
  
  def self.search(params = {}, current_user = nil)        
    
    query_string = ""
    
    if params == {} || params == nil
      return self.order("potential DESC")
    end
    
    if params.delete("followed_users")
      followed_users = true
    end
    
    if params.delete("followers")
      followers = true
    end  
    
    # Commented out because the formatting for the first
    # selector is the same as the rest
    
    #first = params.first
    #params.delete(first[0])
    
    #if self.search_hash.has_value?(first[0])
    #  query_string += "#{first[0]} = TRUE"
    #end
        
    
    
    params.each do |key, value|
      if self.search_hash.has_value?(key)        
        query_string += " AND #{key} = TRUE"                               
      end
    end
    
    
    # postings = IdeaPosting.joins(:tags_list).where(query_string)
    
    postings = IdeaPosting.joins("INNER JOIN tags_lists ON tags_lists.id = idea_postings.id"+query_string)
    
    # I'm pretty sure SQL Selects are faster than ruby loops so the
    # code block below is commented out in favor of the uncommented one above
    
    # tags_lists = TagsList.where(query_string)
    # postings = TagsList.idea_postings(tags_lists)
    
    output = []
    
    postings.each do |posting|
      matches_search = true
      
      if followers
        matches_search = current_user.from_follower?(posting) ? true : false #method in User.rb that checks whether posting is from follower
      end
      
      if followed_users
        matches_search = current_user.from_followed_user?(posting) ? true : false
      end
      
       if matches_search
         output << posting
       end
    end
  
    return output
  end
  
  def tags
    if tags_list
      return tags_list.tags
    else
      return []
    end      
  end

end