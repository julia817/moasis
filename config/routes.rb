Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

	root 'static_pages#home'

	get '/about', to: 'static_pages#about'
	get '/help', to: 'static_pages#help'
	get '/contact', to: 'static_pages#contact'

	resources :users do
    member do
      get :following, :followers, :watched, :want, :recommend, :my_watched, :my_unwatched
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

	get '/signup', to: 'users#new'

	get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/search_movies', to: 'search#search_movies'
  get '/search_people', to: 'search#search_people'
  get '/search_users', to: 'search#search_users'
  get '/search_filter', to: 'search#search_filter' # select search filter page
  get '/search', to: 'search#discover'

  resources :movies
  resources :movielists, only: [:create, :destroy]
  resources :list_movies

  get '/person', to: "movies#show_person"
  
  post 'list_movies/create', to: 'list_movies#create'
  post 'list_movies/create_watched', to: 'list_movies#create_watched'
  post 'list_movies/create_want', to: 'list_movies#create_want'
  post 'list_movies/create_recommend', to: 'list_movies#create_recommend'
  post 'list_movies/create_recommend_from_other', to: 'list_movies#create_recommend_from_other'
  post 'list_movies/create_watched_from_other', to: 'list_movies#create_watched_from_other'
  post 'list_movies/create_want_from_other', to: 'list_movies#create_want_from_other'
  delete 'list_movies/destroy', to: 'list_movies#destroy'

  # SNS log in
  # match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure',            to: 'sessions#auth_failure'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
