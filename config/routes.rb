Rails.application.routes.draw do
  
  devise_for :users
  root 'home#index'

  get 'movies' => 'movies#index'

  get 'movies/stream' => 'movies#stream'

  post 'movies/:movie_id/checkout' => 'movies#checkout'

end
