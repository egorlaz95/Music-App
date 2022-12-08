Rails.application.routes.draw do
  resources :singers
  get 'search/search', to: 'search#search'
  devise_for :users
  root 'albums#index'
  resources :albums do
    collection do
      get 'search', 'artist', 'top_ranked'
    end
    resources :reviews, except: [:show, :index]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
