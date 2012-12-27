Ideagarden::Application.routes.draw do





#  match '/idea_postings/:id/joinrequest_id/' => "joinrequests#create", as "joinrequest_path"
    
  root to:"idea_postings#index"
  
  resources :idea_postings do
    resources :feedbacks
    resources :joinrequests
  end
  
  resources :users do
    resources :profiles
  end

  resource :session
  match '/login' => "sessions#new", as: "login"
  match '/logout' => "sessions#destroy", as: "logout"

  # potential rating
  match '/:id/upvote' => 'potentials#upvote', as: 'upvote'
  match '/:id/downvote' => 'potentials#downvote', as: 'downvote'

  # help rating
  match '/idea_postings/:id/:feedback_id/helpful' => 'helps#helpful', as: 'helpful'
  match '/idea_postings/:id/:feedback_id/unhelpful' => 'helps#unhelpful', as: 'unhelpful'
  

  # approve and reject joinrequests
  match '/idea_postings/:id/joinrequests/:joinrequest_id/approve' => 'joinrequests#approve', as: 'approve_joinrequest'#, :via => :post
  match '/idea_postings/:id/joinrequests/:joinrequest_id/reject' => 'joinrequests#reject', as: 'reject_joinrequest'#, :via => :post
  
  #user can access requests to projects he/she owns from homepage with a short url
  match '/joinrequests' => 'joinrequests#index', as: 'list_joinrequests', :via => :get
  match '/joinrequests' => 'joinrequests#create', as: 'joinrequests', :via => :post
  
  # allows for confirming registration
  match '/confirm/:confirmation_code' => 'users#confirm', as: 'user_confirmation'
  
  # allows for resetting passwords
  
  match '/reset_password' => 'users#new_password_reset_request', as: 'new_pw_reset'
  match '/reset_password/send' => 'users#send_password_reset_request', as: 'send_pw_reset'

  match '/passwords/:reset_code' => 'users#load_password_reset_page', as: 'load_pw_reset', :via => :get
  match '/passwords/:reset_code' => 'users#reset_password', as: 'reset_password', :via => :put
  
  #TEMPORARY, DELETE THIS:
  match '/show_reset_requests' => 'users#show_pw_reset_requests', as: 'show_pw_reset'

  match '/users/:id/follow' => 'users#follow', as: 'follow_user'
  match '/users/:id/unfollow' => 'users#unfollow', as: 'unfollow_user'
  match '/following' => 'idea_postings#show_followings_posts', as: 'show_followings_posts'
  match '/followers' => 'idea_postings#show_followers_posts', as: 'show_followers_posts'
  match '/search' => 'idea_postings#search', as: 'search'

  
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
