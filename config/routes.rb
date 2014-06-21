Bitsy::Engine.routes.draw do

  namespace :v1 do
    resources :payment_depots
    unless Rails.env.production?
      resources :syncs
      resources :truncations
    end
  end

end
