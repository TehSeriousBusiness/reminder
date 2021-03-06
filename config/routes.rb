Reminder::Application.routes.draw do

## adding a routing to destroy all jobs with one call
  match "/jobs/destroyall" => "jobs#destroyall"
  # selecting templates for a new job
  match "/jobs/selecttemplate" => "jobs#selecttemplate"
  match "/jobs/newByTemplate" => "jobs#newByTemplate"
  resources :jobs

  resources :job_templates

  resources :mail_servers

  resources :users
  
  ## creates a new route host.de/login   using the users controller
  match "/users/new" => "users#new"
  match "/" => "users#login"
  match "/myPage" => "users#myPage"
  match "/logout" => "users#logout"
  
  match "/process_login" => "users#process_login"
  
#  match "/login/process" => "users#process_login"
#  map.search “search”, :controller => “search”
  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
