Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/:company_slug/:show_slug/:datetime', to: 'performances#show'
  get '/:company_slug/:show_slug', to: 'shows#show'
  get '/:company_slug', to: 'companies#show'
  root to: 'home#index'
end
