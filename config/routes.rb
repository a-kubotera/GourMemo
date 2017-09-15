Rails.application.routes.draw do
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


  resources :users, only: [:index,:show]
  resources :relationships, only: [:create, :destroy]
end
