Subscribem::Engine.routes.draw do
	root to: "dashboard#index"

	get '/sign_up', to: 'accounts#new', as: :sign_up
end
