ChemcertBakshi::Application.routes.draw do
  devise_for :users

  root 'training_organizations#index'
  resources :training_organizations, :path => "rtos"
  resources :venues do
    collection do
      get '/by_course' => 'venues#by_course'
    end
  end

  resources :courses do
    collection do
      get '/code' => 'courses#by_code'
      get '/schedule' => 'courses#schedule'
      get '/status' => 'courses#status'
      get '/by_town' => 'courses#by_town'
      get '/process' => 'courses#course_process'
      post '/process' => 'courses#course_post_process'
      get '/proforma' => 'courses#proforma'
    end
  end

  resources :towns do
    collection do
      get '/name' => 'towns#by_name'
      get '/by_state' => 'towns#by_state'
    end
  end

  resources :postal_codes do
    collection do
      get '/code' => 'postal_codes#by_code'
    end
  end

  resources :location_relations do
    collection do
      get '/postal_code' => 'location_relations#by_postal_code'
    end
  end

  resources :students do
    collection do
      get '/register' => 'students#register'
      post '/register' => 'students#enroll'
      get '/' => 'students#search'
      post '/update' => 'students#update'
    end
  end

  resources :trainers do
  end



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
end
