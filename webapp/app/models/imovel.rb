class Imovel < ActiveRecord::Base

  has_many :imovel_imagens, :dependent => :destroy
  belongs_to :imovel_site
  attr_accessible :andares, :ano_construcao, :anunciante, :area_util, :areas_comuns, :bairro, :cidade, :condicoes_comerciais, :creci, :data_publicacao, :descricao, :dormitorios, :imagens, :localizacao, :numero_suites, :numero_vagas, :outros_itens, :rua, :telefones, :tipo, :uf, :valor_aluguel, :valor_condominio, :valor_m2, :valor_venda, :url

  def self::pesquisar(campos)
    pesquisa = Imovel
    pesquisa = pesquisa.where(:tipo => campos['tipo']) if campos['tipo']
    pesquisa = pesquisa.where('valor_aluguel > 0') if campos['negociacao'].include? 'aluguel'
    pesquisa = pesquisa.where('valor_venda > 0') if campos['negociacao'].include? 'venda'
    pesquisa = pesquisa.where('(valor_aluguel + valor_condominio) < ?', campos['preco_maximo']) if not campos['preco_maximo'].empty? and campos['negociacao'].include? 'aluguel'
    pesquisa = pesquisa.where('(valor_venda + valor_condominio) < ?', campos['preco_maximo']) if not campos['preco_maximo'].empty? and campos['negociacao'].include? 'venda'
    pesquisa = pesquisa.where('numero_vagas >= ?', campos['numero_vagas']) if campos['numero_vagas']
    pesquisa = pesquisa.where(:cidade => campos['cidade']) if campos['cidade']

    pesquisa.order(:data_publicacao).limit(1000)
  end

end
