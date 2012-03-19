Hippo::Application.routes.draw do
  resources :shares
  resources :contacts
  resources :record_sets
  resources :plans
  resources :subscriptions
  resources :records
  resources :patients
  resources :dentists
  resources :companies

  devise_for :users
  resources :token_authentications, :only => [:create, :destroy]
 
  resources :users do
    member do
      get 'cancel'
    end
  end

  match "searchall" => "dentists#searchall"
  match "inbox" => "shares#inbox"
  match 'send_new_share_email' => 'shares#send_new_share_email'
  match 'create_contact_and_share' => 'shares#create_contact_and_share'
  match 'download_record' => 'records#record'
  match 'thumbnail' => 'records#thumbnail'
 # match 'record_set_views/:id' => 'record_sets/view'

  #match "cancel" => "users#cancel_subscription"
  resources :users, :only => [:show]

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
  root :to => 'contacts#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
