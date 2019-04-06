Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/bookings', to: 'bookings#create', as: :booking_link
  get '/:company_slug/:show_slug/:venue_slug/:datetime', to: 'performances#show', as: :performance_link
  get '/:company_slug/:show_slug/:venue_slug', to: 'shows#show', as: :show_venue_link
  get '/:company_slug/:show_slug', to: 'shows#show', as: :show_link
  get '/:company_slug', to: 'companies#show', as: :company_link
  root to: 'home#index'
end
