Filas::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  root to: "home#index"

  get "filas/atualizar_senha"
  get "filas/acompanhar_fila"

  resources :filas

  resources :filas do
    member do
      get :acessar_atualizar_senha
      get :atualizar_senha
      get :acessar_acompanhamento_fila
    end
  end

end
