Rails.application.routes.draw do
  resources :feeds do
    collection do
      post :confirm
    end
  end
  
  resources :users,only:[:new,:create,:show,:edit,:update]
  resources :sessions,only:[:new,:create,:destroy]
  resources :feeds

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
