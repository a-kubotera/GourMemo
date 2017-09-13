Rails.application.routes.draw do
  resources :blogs
  devise_for :users
  root 'top#index'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  devise_scope :user do
    get '/log_out' => 'devise/sessions#destroy'
  end
end
