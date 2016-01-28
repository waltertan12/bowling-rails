Rails.application.routes.draw do
  root to: 'static_pages#index'

  namespace :api, defaults: {format: :json} do
    resources :games, except: [:new, :update, :edit]
    post 'games/bowl' => 'games#bowl'
  end
end
