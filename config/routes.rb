Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  # autenticate user before go
  authenticate :user do
    resources :users, only: %i(update destroy)
  end

  authenticated :user do
    root 'home#index', as: :root
  end
  unauthenticated :user do
    root 'landing#index', as: :landing_root
  end

  # capture all non-existing routes
  get '*any', via: :all, to: redirect('/404'), constraints: -> (req) { !req.fullpath.start_with?('/rails') }
end
