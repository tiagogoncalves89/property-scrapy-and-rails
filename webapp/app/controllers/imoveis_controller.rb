#encoding: utf-8

class ImoveisController < ApplicationController

  def pesquisa
    @aluguel = params['aluguel']
    @venda = params['venda']

    params[:q] = {} unless params[:q]
    params[:q].store(:aluguel_true, '1') if @aluguel
    params[:q].store(:venda_true, '1') if @venda

    @search = Imovel.search(params[:q])
    @imoveis = @search.result
  end

end