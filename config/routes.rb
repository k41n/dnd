Dnd::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :players, controllers: { sessions: 'sessions' }
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'dashboard#index'

  namespace :api, defaults: { format: 'json' } do
    resources :armors    
    resources :character_abilities
    resources :weapons
    resources :character_classes
    resources :deities
    resources :perks
    resources :logs
    resources :characters do
      post :avatar, on: :member
      collection do
        post :invite
        post 'accept/:invitation_id' => 'characters#accept'
        delete :uninvite
        delete :kick
        get :my
      end
    end
    resources :invites do
      member do
        post :accept
      end
    end
    resources :skills
    resources :races
    resources :monsters
    resources :games do
      resources :combats, shallow: true do
        member do
          post :background
          post :reset
        end
      end
    end
  end

end
