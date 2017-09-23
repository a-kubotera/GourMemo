Rails.application.routes.draw do


  get 'relationships/create'
  get 'relationships/destroy'

  root 'top#index'

  get 'index2', to: 'top#index2', as: :top


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  #ログイン情報の破棄を　log out と呼びたい
  devise_scope :user do
    get '/log_out' => 'devise/sessions#destroy'
  end
  # SNSログイン
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  #ユーザー周り
  resources :users, only: [:index,:show] do

  end
  #記事周り
  resources :articles do
    resources :likes,  only: [:create, :destroy]
    resources :evaluates, only: [:index,:show,:new]
  end

  #フォロー関連
  resources :relationships, only: [:create, :destroy]
end
