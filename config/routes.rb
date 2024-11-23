Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :sleep_records do
    collection do
      post :clock_in
      patch "clock_out/:id", action: "clock_out"
      get ":user_id/me", action: "my_sleep_records"
      get ":user_id/following", action: "following_sleep_records"
      get ":user_id/follower", action: "follower_sleep_records"
    end
  end

  resources :friends, only: [ :create, :destroy ]
end
