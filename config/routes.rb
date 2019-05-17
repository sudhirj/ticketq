Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #

  get '/auth/oauth2/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'

  namespace :admin do
    resources :companies do
      resources :shows
      resources :performances
    end
    get '/' => 'dashboard#index'

  end

  resources :reports

  post '/bookings', to: 'bookings#create', as: :create_booking_link
  get '/:company_slug/:show_slug/:venue_slug/:datetime', to: 'performances#show', as: :performance_link
  get '/:company_slug/:show_slug/:venue_slug', to: 'shows#show', as: :show_venue_link
  get '/:company_slug/:show_slug', to: 'shows#show', as: :show_link
  get '/:receipt', to: 'bookings#show', as: :booking_link, constraints: { receipt: /TQ-.+/ }
  get '/:company_slug', to: 'companies#show', as: :company_link
  root to: 'home#index'
end
