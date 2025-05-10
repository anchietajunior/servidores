Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :servers do
    collection do
      get :index_pdf
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "servers#index"
end
