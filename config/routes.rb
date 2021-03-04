Rails.application.routes.draw do

  devise_for :users
  root to: 'home#top'
  get  'home/about'
  post 'follow/:id'         => 'relationships#follow',    as: 'follow'
  post 'unfollow/:id'       => 'relationships#unfollow',  as: 'unfollow'
  get  'user/:id/follows'   => 'relationships#follows',   as: 'follows'
  get  'user/:id/followers' => 'relationships#followers', as: 'followers'
  get  '/search'            => 'searches#search'
  
  resources :users
  resources :books do
    resource    :favorites,     only: [:create, :destroy]
    resources   :book_comments, only: [:create, :destroy]
  end

end
