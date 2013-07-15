Refinery::Application.routes.draw do

  filter(:refinery_locales) if defined?(RoutingFilter::RefineryLocales) # optionally use i18n.

  root :to => 'pages#home'
  match 'sitemap', :to => 'pages#sitemap'

  # Features are mapped in /explore
  resources :features, :path => 'explore'
  match 'features/random', :to => 'features#random'
  match 'features/institutions', :to => 'features#institutions'

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    root :to => 'dashboard#index'
  end

  resource :twitter, :only => :show

end
