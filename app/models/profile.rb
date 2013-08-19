class Profile < ActiveRecord::Base

  validates :name, :presence => true
  validates :name, :bio, :user_id, :presence => true
  attr_accessible :bio, :name, :user_id, :photo
  

  belongs_to :user

  has_attached_file :photo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  API_KEY='e0e33a5fcc83690e15b85109f79f152d'
  SHARED_SECRET='e3bd1896168ca154'
  ACCESS_TOKEN='72157634656525998-d9874a6f24891f01'
  ACCESS_SECRET='d9f738083bb0df54'
  def self.save(upload)
    require 'flickraw'

    FlickRaw.api_key = API_KEY
    FlickRaw.shared_secret = SHARED_SECRET
    flickr.access_token = ACCESS_TOKEN
    flickr.access_secret = ACCESS_SECRET
    photo_path=@photo
      
    flickr.upload_photo photo_path, :title => 'Title', :description => 'This is the description'
        
    name =  upload['datafile'].original_filename
    directory = "public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end
  
end