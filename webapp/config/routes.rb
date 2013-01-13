Imoveis::Application.routes.draw do

  root :to => 'imoveis#index', :as => 'imoveis'
  match 'imoveis/aluguel' => 'imoveis#pesquisa', :defaults => { :aluguel => true }, :via => :get, :as => 'imoveis_aluguel'
  match 'imoveis/venda' => 'imoveis#pesquisa', :defaults => { :venda => true }, :via => :get, :as => 'imoveis_venda'
  
end