Rails.application.routes.draw do
  resources :feeds do
    collection do
      post :confirm
    end
  end

  resources :users,only:[:new,:create,:show,:edit,:update] do
    member do
      get :favorites
    end
  end

  resources :sessions,only:[:new,:create,:destroy]
  resources :favorites, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
