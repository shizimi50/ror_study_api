Rails.application.routes.draw do
  resources :posts do
    collection do
      get 'search'
    end
    collection do
      get 'count'
    end
   resources :comments do
    collection do
      get 'count'
    end
   end
  end
end
