class Imovel < ActiveRecord::Base

  has_many :imovel_imagens, :dependent => :destroy
  belongs_to :imovel_site
  attr_accessible :andares, :ano_construcao, :anunciante, :area_util, :areas_comuns, :bairro, :cidade, :condicoes_comerciais, :creci, :data_publicacao, :descricao, :dormitorios, :imagens, :localizacao, :numero_suites, :numero_vagas, :outros_itens, :rua, :telefones, :tipo, :uf, :valor_aluguel, :valor_condominio, :valor_m2, :valor_venda, :url, :aluguel, :venda

end