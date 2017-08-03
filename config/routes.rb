Rails.application.routes.draw do
  root 'processings#new'

  resources :processings, only: %i[create new show]
end
