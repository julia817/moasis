Rails.application.routes.draw do

  	# get 'movies/index'
  	get '/search', to: 'search#search_movies'

	root 'static_pages#home'

	get '/about', to: 'static_pages#about'
	get '/help', to: 'static_pages#help'
	get '/contact', to: 'static_pages#contact'

	resources :users
	get '/signup', to: 'users#new'
	# get '/signup', to: 'users#create'

	get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :movies
  resources :movielists, only: [:create, :destroy]
  resources :list_movies

  post 'list_movies/create', to: 'list_movies#create'
  post 'list_movies/create_watched', to: 'list_movies#create_watched'
  post 'list_movies/create_want', to: 'list_movies#create_want'
  post 'list_movies/create_recommend', to: 'list_movies#create_recommend'
  post 'list_movies/create_recommend_from_other', to: 'list_movies#create_recommend_from_other'
  post 'list_movies/create_watched_from_other', to: 'list_movies#create_watched_from_other'
  post 'list_movies/create_want_from_other', to: 'list_movies#create_want_from_other'
  delete 'list_movies/destroy', to: 'list_movies#destroy'

  get 'users/:id/watched', to: 'users#watched'
  get 'users/:id/want', to: 'users#want'
  get 'users/:id/recommend', to: 'users#recommend'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
