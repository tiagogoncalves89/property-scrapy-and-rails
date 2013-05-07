class Property < ActiveRecord::Base

  has_many :property_images, :dependent => :destroy
  belongs_to :property_source
  attr_accessible :andares, :ano_construcao, :anunciante, :area_util, :areas_comuns, :bairro, :cidade, :condicoes_comerciais, :creci, :data_publicacao, :descricao, :dormitorios, :images, :localizacao, :numero_suites, :numero_vagas, :outros_itens, :rua, :telefones, :tipo, :uf, :valor_aluguel, :valor_condominio, :valor_m2, :valor_venda, :url, :aluguel, :venda

end