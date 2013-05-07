Properties::Application.routes.draw do

  root :to => 'properties#index', :as => 'properties'
  match 'properties/aluguel' => 'properties#pesquisa', :defaults => { :aluguel => true }, :via => :get, :as => 'properties_aluguel'
  match 'properties/venda' => 'properties#pesquisa', :defaults => { :venda => true }, :via => :get, :as => 'properties_venda'

end