class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  
    # Returns the currently logged in user or nil if there isn't one
    def current_user
      return unless session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id]) 
    end

    # Make current_user available in templates as a helper
    helper_method :current_user

    # Predicate method to test for a logged in user    
    def logged_in?
      current_user.is_a? User
    end

    # Make logged_in? available in templates as a helper
    helper_method :logged_in?

    def number_of_requests
    if @current_user == nil
      @number_of_requests = nil
    else
      @user = User.find(@current_user.id)
      @number_of_requests = 0
      for owned_idea_posting in @current_user.idea_postings.all
        for requests in owned_idea_posting.joinrequests.all
          @number_of_requests +=1
       end
      end
    end
    return @number_of_requests
    end
    
    helper_method :number_of_requests
    
    
    def registration_complete?
      if current_user != nil && current_user.profile != nil
        return true
      else
        return false
      end
    end
    
    helper_method :registration_complete?
    
    def registration_filter
      if current_user != nil && current_user.profile != nil
        return true
      else
        return redirect_to root_path, :notice => 'Please complete registration by creating your profile to access this feature'
      end
    end
    
    helper_method :registration_filter
    
    def login_filter
      if current_user == nil
        return redirect_to root_path, :notice => 'Please log in to access this feature'
      end
    end
    
    helper_method :login_filter
    
    
    def create_tags
    if params["technology"] != nil
      @idea_posting.tags.new({:value => params["technology"]})
    end
    
    if params["science & math"] != nil
      @idea_posting.tags.new({:value => params["science & math"]})
    end
    
    
    if params["language"] != nil
      @idea_posting.tags.new({:value => params["language"]})
    end
            
    if params["art"] != nil
      @idea_posting.tags.new({:value => params["art"]})
    end
    
    if params["community service"] != nil
      @idea_posting.tags.new({:value => params["community service"]})
    end
    
    if params["research"] != nil
      @idea_posting.tags.new({:value => params["research"]})
    end
    
    if params["making things"] != nil
      @idea_posting.tags.new({:value => params["making things"]})
    end
        
    end
    
    helper_method :create_tags
end
