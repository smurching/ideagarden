desc "This task is called by the Heroku scheduler add-on"

task :update_featured_posts => :environment do
  IdeaPosting.update_featured_posts
end