Rails.application.routes.draw do
  resources :people, param: :random_id
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
