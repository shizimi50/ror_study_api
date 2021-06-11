Rails.application.routes.draw do
  #post系ルーティング
  get "posts/get" => "posts#get"
  post "posts/create" => "posts#create"
  put "posts/edit" => "posts#edit"
  get "posts/count" => "posts#count"
  delete "posts/delete" => "posts#destroy"
  get "posts/show" => "posts#show"
  #comment系ルーティング
  post "comments/new" =>"comments#new"
  get 'comments/get'=>"comments#get"
  get 'comments/count'=>"comments#count"
end
