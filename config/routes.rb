Rails.application.routes.draw do
  resources :questions

  root to: "pages#index"
end
