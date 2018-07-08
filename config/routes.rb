Rails.application.routes.draw do

  resources :companies

  resources :dashboard, only: [:index]

  resources :categories

  resources :jobs do
    resources :comments
  end

  resources :comments, only: [:index, :create]

  resources :companies do
    resources :contacts
  end

  resources :contacts, only: [:index, :create, :edit, :update]

  resources :categories do
    resources :jobs
  end
end

=begin
resources :artists, shallow: true do
  resources :songs
end

resources :songs, only: [:index]
=end
