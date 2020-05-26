Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  root "menus#index"
  resources :mains do
    collection do
      get "menu_index"
    end
    collection do
      get 'search'
    end
  end
  resources :subs do
    collection do
      get "menu_index"
    end
    collection do
      get 'search'
    end
  end
  resources :soops do
    collection do
      get "menu_index"
    end
    collection do
      get 'search'
    end
  end
  resources :menus do
    resources :mains, only:[:index]
    resources :subs, only:[:index]
    resources :soops, only:[:index]
    collection do
      get "menu_index"
    end
  end

  

end
