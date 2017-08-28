Rails.application.routes.draw do
  root 'homes#home'

  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions"}
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }
      #common
      get 'video_url', to: 'users#video_url'
      get 'user_detail', to: 'users#user_detail'
      get 'admin_post', to: 'users#admin_post'
      get 'profile', to: 'users#profile'
      put 'profile_edit', to: 'users#profile_edit'
      get 'profile_detail', to: 'users#profile_detail'
      get 'user_signout', to: 'users#user_signout'

      # student
      post 'create_request', to: 'requests#create_request'
      get 'student_history', to: 'users#student_history'
      post 'user_feedback/:prophent_message_id', to: 'users#user_feedback'

      # prophent
      get 'prophent_history', to: 'users#prophent_history'
      get 'prophents', to: 'prophents#prophents'
      get 'pending_request', to: 'requests#pending_request'
      get 'accept_request/:id', to: 'requests#accept_request'
      post 'prophents_message', to: 'prophents#prophent_message_create'
      get 'prophents_message/:id', to: 'prophents#prophent_message_show'
      get 'prophent_messages', to: 'prophents#prophent_messages'

      #admin
      post 'prophent_create', to: 'admins#prophent_create'
      get 'prophent_list', to: 'admins#index'
      get 'all_prophent_messages', to: 'admins#all_prophent_messages'
      post 'admin_posts_create', to: 'admins#admin_posts_create'
      put 'admin_posts_update/:admin_post_id', to: 'admins#admin_posts_update'
      delete 'admin_posts_delete/:admin_post_id', to: 'admins#admin_posts_delete'
      get 'admin_posts', to: 'admins#admin_posts'
    end
  end
  get 'homes/terms'
  get 'homes/index'
  get 'homes/admin'
  post 'homes/admin'
  get 'homes/profile'
  get 'homes/prophet_home'
  get 'homes/your_story'
  get 'homes/user_history_message'
  get 'homes/prophet_histroy_message'
  get 'homes/user_feedback_message'
  get 'homes/prophet_message'
  get 'homes/user_feedback'

  # Admin create prophet
  get 'users/prophet_new'
  post 'users/prophet_create'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  get "users/:name" => "users#show_profile", as: :profile
  get "/history" => "users#student_history", as: :student_history
  get "request/create_request" => "requests#create_request", as: :create_request
  get 'request/accept_request/:id' => 'requests#accept_request', as: :accept_request
  delete 'delete_request/:id' => 'requests#delete_request', as: :delete_request 
  get 'video_url' => 'admin_posts#video_url', as: :video_url 
  post 'save_video_url' => 'admin_posts#save_video_url', as: :save_video_url 
  patch 'save_video_url' => 'admin_posts#save_video_url'
  resources :prophents, only: [:index]
  resources :prophent_messages do
    resources :user_feedbacks, only: [:new, :create]
  end
  resources :admin_posts
end
