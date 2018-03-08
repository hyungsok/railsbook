Rails.application.routes.draw do
  get 'books/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts

  # match ":controller(/:action(:id))", via: [:get, :post, :patch]
  resources :books

  resources :products do
    collection do
      post :import
    end
  end


  # root 뷰를 해당 주소로
  # get 'home/index'

  root :to => "home#index"
end
