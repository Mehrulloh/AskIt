Rails.application.routes.draw do

  concern :commentable do
    resources :comments, only: %i[create destroy]
  end

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    resource :session, only: %i[new create destroy]

    resources :users, only: %i[new create edit update]

    resources :answers, except: %i[new show], concerns: :commentable

    resources :questions, concern: :commentable do
      resources :answers, except: %i[new show]
    end

    namespace :admin do
      resources :users, only: %i[index create edit update destroy]
    end

    root to: 'pages#index'
  end
end
