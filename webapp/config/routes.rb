Properties::Application.routes.draw do

  root :to => 'properties#index', :as => 'properties'
  match 'properties/rent' => 'properties#pesquisa', :defaults => { :rent => true }, :via => :get, :as => 'properties_rent'
  match 'properties/sell' => 'properties#pesquisa', :defaults => { :sell => true }, :via => :get, :as => 'properties_sell'

end