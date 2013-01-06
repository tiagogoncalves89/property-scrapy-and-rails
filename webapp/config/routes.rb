Imoveis::Application.routes.draw do

  root :to => 'imoveis#index'
  post 'imoveis/listar'
  
end