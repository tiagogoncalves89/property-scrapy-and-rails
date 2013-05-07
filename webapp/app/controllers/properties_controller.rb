#encoding: utf-8

class PropertiesController < ApplicationController

  def pesquisa
    @aluguel = params['aluguel']
    @venda = params['venda']

    params[:q] = {} unless params[:q]
    params[:q].store(:aluguel_true, '1') if @aluguel
    params[:q].store(:venda_true, '1') if @venda

    @search = Property.search(params[:q])
    @properties = @search.result
  end

end