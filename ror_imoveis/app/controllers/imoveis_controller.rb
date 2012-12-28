#encoding: utf-8

class ImoveisController < ApplicationController

  def index
    @tipos = Imovel.select(:tipo).uniq.collect { |imovel| imovel.tipo }
    @cidades = Imovel.select(:cidade).uniq.collect { |imovel| imovel.cidade }
  end

  def listar
    @imoveis = Imovel.pesquisar(params)
    @venda = params['negociacao'].include? 'venda'
    @aluguel = params['negociacao'].include? 'aluguel'
  end 

end