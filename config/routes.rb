Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/login' => "user#login", as: :login_post

  get '/users' => "user#index", as: :get_users
  post '/users' => "user#create", as: :register_user

  get '/comments' => "comment#index", as: :get_comments
  post '/comments' => "comment#create", as: :create_comment
  get '/comments/:id' => "comment#show", as: :get_comment
  patch '/comments' => "comment#update", as: :patch_comment
  delete '/comments' => "comment#destroy", as: :delete_comment

end
