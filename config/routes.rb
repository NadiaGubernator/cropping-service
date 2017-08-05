Rails.application.routes.draw do
  root 'processings#new'

  resources :processings, except: :destroy
end
