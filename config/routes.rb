Filas::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  root to: "home#index"

  get "filas/atualizar_senha"

  resources :filas

  resources :filas do
    member do
      get :acompanhar_fila
      get :atualizar_senha
    end
  end

end
