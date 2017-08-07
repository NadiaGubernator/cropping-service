Rails.application.routes.draw do
  root 'processings#index'

  resources :processings, except: :destroy
end
