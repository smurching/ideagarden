
class Profile < ActiveRecord::Base

  validates :name, :presence => true
  # validates :user_id, :presence => true
  
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

  def complete?
    return self.bio != nil && self.bio != ""
  end

# class Profile < ActiveRecord::Base

#   validates :name, :presence => true
#   validates :name, :bio, :user_id, :presence => true
#   attr_accessible :bio, :name, :user_id, :photo
  

#   belongs_to :user

#   has_attached_file :photo, styles: {
#     thumb: '100x100>',
#    square: '200x200#',
#    medium: '300x300>'
#  }

#  API_KEY='e0e33a5fcc83690e15b85109f79f152d'
#  SHARED_SECRET='e3bd1896168ca154'
#  ACCESS_TOKEN='72157634656525998-d9874a6f24891f01'
#  ACCESS_SECRET='d9f738083bb0df54'
#  def self.save(upload)
#    require 'flickraw'

#    FlickRaw.api_key = API_KEY
#    FlickRaw.shared_secret = SHARED_SECRET
#    flickr.access_token = ACCESS_TOKEN
#    flickr.access_secret = ACCESS_SECRET
#    photo_path=@photo
      
#    flickr.upload_photo photo_path, :title => 'Title', :description => 'This is the description'
        
#    name =  upload['datafile'].original_filename
#    directory = "public/data"
    # create the file path
#    path = File.join(directory, name)
    # write the file
#    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
#  end
  
# end



end