#encoding: utf-8

class PropertiesController < ApplicationController

  def pesquisa
    @rent = params['rent']
    @sell = params['sell']

    params[:q] = {} unless params[:q]
    params[:q].store(:rent_true, '1') if @rent
    params[:q].store(:sell_true, '1') if @sell

    @search = Property.search(params[:q])
    @properties = @search.result
  end

end