Bitsy::Application.routes.draw do
  namespace :v1 do
    resources :payment_depots
  end
end
