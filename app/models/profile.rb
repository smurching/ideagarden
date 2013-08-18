class Profile < ActiveRecord::Base

  validates :name, :presence => true
  validates :name, :bio, :user_id, :presence => true
  
  attr_accessible :bio, :name, :user_id, :photo
  

  belongs_to :user

  has_attached_file :photo, styles: { small: "130x130>", thumb: "45x45>" }
 
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