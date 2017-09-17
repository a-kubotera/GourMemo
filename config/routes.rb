Rails.application.routes.draw do
  get 'articles/index'

  get 'articles/show'

  get 'articles/new'

  get 'articles/confirm'

  get 'relationships/create'
  get 'relationships/destroy'

  devise_for :users

  root 'top#index'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  devise_scope :user do
    get '/log_out' => 'devise/sessions#destroy'
  end


  resources :users, only: [:index,:show] do
    resources :articles
  end
  resources :articles, only: [:index,:show] do
    resources :likes,  only: [:create, :destroy]
    resources :evaluates
  end

  resources :relationships, only: [:create, :destroy]
end
