Rails.application.routes.draw do
  get 'favourites/view'
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    resources :singers
    get 'search/search', to: 'search#search'
    devise_for :users
    root 'albums#index'
    resources :albums do
      collection do
        get 'search', 'artist', 'top_ranked', 'worst_ranked', 'favourite'
      end
      resources :reviews, except: %i[show index]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
