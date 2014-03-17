Dnd::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :players, controllers: { sessions: 'sessions' }
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'dashboard#index'

  namespace :api, defaults: { format: 'json' } do
    resources :characters do
      post :avatar, on: :member
      collection do
        post :invite
        delete :uninvite
        get :my
      end
    end
    resources :skills
    resources :races
    resources :monsters
    resources :games do
      resources :combats, shallow: true do
        post :background, on: :member
      end
    end
  end

end
