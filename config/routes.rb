Rails.application.routes.draw do
  #投稿一覧ページ用のルーティング
  get 'posts/index'=>'posts#index'
  #新規投稿ページ用のルーティング
  get "posts/new" => "posts#new"
  #データを送信するためのルーティング
  post "posts/create" => "posts#create"
  

end
