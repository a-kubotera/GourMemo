Rails.application.routes.draw do
  root 'top#index'

  # TOPページ関連
  get 'index2', to: 'top#index2', as: :toppage
  get 'index', to: 'top#index', as: :landingpage

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # ログイン情報の破棄を logout と呼びたい
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy'
  end 

  # SNSログイン
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # ユーザー周り
  resources :users, only: %i[index show]

  #記事周り
  resources :articles do
    resources :likes, only: %i[create destroy]
    resources :evaluates, only: %i[index new edit create update]
  end

  # フォロー関連
  resources :relationships, only: %i[create destroy]
end
