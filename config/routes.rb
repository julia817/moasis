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

	get '/login', to: "sessions#new"
    post '/login', to: "sessions#create"
    delete '/logout', to: "sessions#destroy"

    resources :movies

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
