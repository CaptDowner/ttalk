Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :phrases
  resources :category_phrases
  resources :categories
#  get "signup" => "users#new", :as => "signup"
  get 'phrases/edit'
  get 'phrases/show'
  get 'phrases/new'
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
end
