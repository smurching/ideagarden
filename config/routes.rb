Ideagarden::Application.routes.draw do






#  match '/idea_postings/:id/joinrequest_id/' => "joinrequests#create", as "joinrequest_path"
    
  root to:"idea_postings#index"
  
  resources :idea_postings do
    resources :feedbacks
    resources :joinrequests

  end
  
  resources :private_messages
    
  resources :users do
    resources :profiles
  end

  resource :session
  match '/login' => "sessions#new", as: "login"
  match '/logout' => "sessions#destroy", as: "logout"
  
  #facebook login/registration
  match '/fb_login' => "sessions#create", as: "fb_login"
  match '/fb_register' => "users#create", as: "fb_register"
  match '/users/:user_id/profiles' => "profiles#create", as: "fb_profile_create", :via => :put
  match '/channel.html' => "idea_postings#channel", as: "channel_path"
  
  #facebook posting
  match '/idea_postings/:id/fb_post' => "idea_postings#fb_post", as: "fb_post"
  match '/idea_postings/:id/fb_share' => "idea_postings#share_fb_post", as: "share_fb_post"
  match '/opengraph_object/:id' => "idea_postings#opengraph_object", as: "fb_object"

  # potential rating
  match '/:id/upvote' => 'votes#posting_vote', as: 'upvote'
  match '/:id/unvote' => 'votes#posting_unvote', as: 'unvote'

  # help rating
  match '/idea_postings/:id/:feedback_id/helpful' => 'helps#helpful', as: 'helpful'
  match '/idea_postings/:id/:feedback_id/unhelpful' => 'helps#unhelpful', as: 'unhelpful'
  

  # approve and reject joinrequests
  match '/idea_postings/:id/joinrequests/:joinrequest_id/approve' => 'joinrequests#approve', as: 'approve_joinrequest'#, :via => :post
  match '/idea_postings/:id/joinrequests/:joinrequest_id/reject' => 'joinrequests#reject', as: 'reject_joinrequest'#, :via => :post
  
  #this reply action creates child feedback - feedback that is posted in response to other feedback
  match '/idea_posting/:id/reply/:feedback_id' => 'feedbacks#new_reply', as: 'new_reply', :via => :get #creates actual reply, the action to load the reply template is just feedbacks#new
  match '/idea_posting/:id/reply/:feedback_id' => 'feedbacks#create_reply', as: 'create_reply', :via => :post
  match '/idea_posting/:id/cancel/:feedback_id' => 'feedbacks#cancel_reply', as: 'cancel_reply', :via => :post
  
  #user can access requests to projects he/she owns from homepage with a short url
  match '/joinrequests' => 'joinrequests#index', as: 'list_joinrequests', :via => :get
  match '/joinrequests' => 'joinrequests#create', as: 'joinrequests', :via => :post
  
  # allows for confirming registration
  match '/confirm/:confirmation_code' => 'users#confirm', as: 'user_confirmation'
  match '/resend_confirmation' => 'users#resend_confirmation', as: 'resend_user_confirmation'
  
  # allows for resetting passwords
  
  match '/reset_password' => 'users#new_password_reset_request', as: 'new_pw_reset'
  match '/reset_password/send' => 'users#send_password_reset_request', as: 'send_pw_reset'

  match '/passwords/:reset_code' => 'users#load_password_reset_page', as: 'load_pw_reset', :via => :get
  match '/passwords/:reset_code' => 'users#reset_password', as: 'reset_password', :via => :put
  
  #TEMPORARY, DELETE THIS:
  match '/show_reset_requests' => 'users#show_pw_reset_requests', as: 'show_pw_reset'

  match '/users/:id/follow' => 'users#follow', as: 'follow_user'
  match '/users/:id/unfollow' => 'users#unfollow', as: 'unfollow_user'
  match '/following' => 'users#show_following', as: 'show_following'
  match '/followers' => 'users#show_followers', as: 'show_followers'
  
  # search/filter actions
  match '/search' => 'idea_postings#search', as: 'search'
  match '/filter_by_followers' => 'idea_postings#filter_by_followers', as: 'filter_by_followers'
  
  match '/sessions/new_login_or_register' => 'sessions#new_login_or_register', as: 'new_login_or_register'

  match '/sessions/new_login_or_register' => 'sessions#create_login_or_register', as: 'create_login_or_register'  
  match '/existing_user' => 'users#existing_user', as: 'existing_user_path'
  
  match '/idea_postings/:idea_posting_id/feedbacks/:id/update' => "feedbacks#update", as: 'update_idea_posting_feedback'
  match '/private_messages/filter' => "private_messages#filter", as: 'filter_private_messages'
  
  #login with facebook
  match 'auth/:provider/callback' => 'sessions#create', as: "facebook_login"
  match 'auth/failure' => 'idea_postings#index', as: "facebook_login_fail"

  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
