# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/topics/items.html

from scrapy.item import Item, Field

class ImovelItem(Item):
  valor_aluguel = Field()
  valor_condominio = Field()
  valor_venda = Field()
  valor_m2 = Field()
  numero_suites = Field()
  numero_vagas = Field()
  dormitorios = Field()
  andares = Field()
  ano_construcao = Field()
  area_util = Field()
  descricao = Field()
  tipo = Field()
  localizacao = Field()
  uf = Field()
  cidade = Field()
  bairro = Field()
  rua = Field()
  anunciante = Field()
  creci = Field()
  areas_comuns = Field()
  condicoes_comerciais = Field()
  outros_itens = Field()
  telefones = Field()
  imagens = Field()
  data_publicacao = Field()
  url = Field()