Rails.application.routes.draw do
  get 'home', to: 'static#home'
  get 'contact', to: 'static#contact'
  get 'privacy', to: 'static#privacy'

  resources :people, param: :random_id
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static#home'
end
