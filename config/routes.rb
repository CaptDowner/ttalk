Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  resources :phrases
  resources :users
  resources :category_phrases
  resources :categories
#  resources :sessions
  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  get "sessions/create"
  get "sessions/destroy"
  get "signup" => "users#new", :as => "signup"

  get 'phrases/create'
  get '/about', to: 'high_voltage/pages#show', id: 'about'
  get '/faq', to: 'high_voltage/pages#show', id: 'faq'
  get '/oftenused', to:  'high_voltage/pages#show', id: 'oftenused'
  get '/are', to: 'high_voltage/pages#show', id: 'are'
  get '/can', to: 'high_voltage/pages#show', id: 'can-i-you'
  get '/do-you', to: 'high_voltage/pages#show', id: 'do_you'
  get '/how', to: 'high_voltage/pages#show', id: 'how'
  get '/directions', to:  'high_voltage/pages#show', id: 'directions'
  get '/i', to: 'high_voltage/pages#show', id: 'i'
  get '/what', to: 'high_voltage/pages#show', id: 'what'
  get '/wwwww', to: 'high_voltage/pages#show', id: 'wwwww'
  root to: 'visitors#index'

end
