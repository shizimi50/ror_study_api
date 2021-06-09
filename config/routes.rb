Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :posts do
        member do
          get :specific_comments
        end
      end
      resources :comments
    end
  end
end
