Bitsy::Engine.routes.draw do

  namespace :v1 do
    resources :payment_depots
    resources :blockchain_notifications
    unless Rails.env.production?
      resources :syncs
      resources :truncations
    end
  end

end
