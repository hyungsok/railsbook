Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts

  # match ":controller(/:action(:id))", via: [:get, :post, :patch]
  resources :books

  get 'records' => 'records#index'

  resources :products do
    collection do
      post :import
    end
  end

  # get ':controller(/:action(/:id(.:format)))'
  # post ':controller(/:action(/:id(.:format)))'
  # patch ':controller(/:action(/:id(.:format)))'
  match ':controller(/:action(/:id))', via: [:get, :post, :patch]

  # root 뷰를 해당 주소로
  # get 'home/index'

  root :to => "home#index"
end
