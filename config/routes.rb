Dnd::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'dashboard#index'

  namespace :api, defaults: { format: 'json' } do
    resources :players, only: [:index]
  end

end
