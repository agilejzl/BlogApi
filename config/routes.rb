require "#{Rails.root}/app/api/api"

Rails.application.routes.draw do
  resources :articles

  mount API::Base => '/'

  root :to => 'home#index'
end
