class TagsList < ActiveRecord::Base
  
  # attr_protected :idea_posting_id
  attr_protected :id  
  belongs_to :idea_posting
  
  
  
  def tags
    tags = []
    
    if technology
      tags << "technology"
    end
    
    if science_and_math
      tags << "science & math"
    end 
    
    if art
      tags << "art"
    end
    
    if language
      tags << "language"
    end
    
    if community_service
      tags << "community service"
    end
    
    if making_things
      tags << "making things"
    end
    
    if research
      tags << "research"
    end
    
    return tags
        
  end
  
  def self.idea_postings(list_of_tag_lists)
    list = list_of_tag_lists
    postings = []
    
    list.each do |tag_list|
      postings << IdeaPosting.find(tag_list.idea_posting_id)
    end
    
    return postings
  end
  
  def set_attributes(params = {})    
    params.each do |key, value|
      puts("key : "+key.to_s+" value: "+value.to_s+"\n")
      if value == "true" && ["facebook", "under_execution", "photo"].include?(key) == false
        puts("@$ PARAMS VALUE : "+value)
        if key == "technology"
          self.technology = true  
        end
        
        if key == "science_and_math"
          self.science_and_math = true  
        end
        
        if key == "art"
          self.art = true  
        end        
        
        if key == "language"
          self.language = true  
        end
        
        if key == "community_service"
          self.community_service = true  
        end                
        
        if key == "research"
          self.research = true  
        end        
                
        if key == "making_things"
          self.making_things = true  
        end                
      end
      
    end       
    
  end
  
  
end