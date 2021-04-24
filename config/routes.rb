Rails.application.routes.draw do
  resources :api do
    resources :v1 do
      resource :forecast, only: [:index]
      resource :backgrounds, only: [:index]
      resource :sessions, only: [:create]
      resource :users, only: [:create]
    end
  end
end
