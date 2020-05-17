Rails.application.routes.draw do
  # ログイン機能
  get '/login' => 'users#login_form'
  post '/login' => 'users#login'
  post '/login_simple' => 'users#login_simple'
  post '/logout' => 'users#logout'

  # ユーザー管理機能
  get 'users/:id/edit' => 'users#edit'
  get 'users/index' => 'users#index'
  get 'users/:id' => 'users#show'
  get 'signup' => 'users#new'
  get 'users/:id/likes' => 'users#likes'
  get 'users/:user_id/followings' => 'users#followings'
  get 'users/:user_id/followers' => 'users#followers'
  post 'users/:id/update' => 'users#update'
  post 'users/create' => 'users#create'

  # 投稿機能
  get 'posts/index'
  get 'posts/:id' => 'posts#show'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/create' => 'posts#create'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'

  # いいね機能
  post 'likes/:post_id/create' => 'likes#create'
  post 'likes/:post_id/destroy' => 'likes#destroy'

  # フォロー機能
  post 'follows/:user_id/create' => 'follows#create'
  post 'follows/:user_id/destroy' => 'follows#destroy'

  # トップ画面
  get '/' =>'home#top'
  get 'about' =>'home#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
