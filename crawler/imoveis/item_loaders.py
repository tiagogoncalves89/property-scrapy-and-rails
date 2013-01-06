from scrapy.contrib.loader import XPathItemLoader
from scrapy.contrib.loader.processor import TakeFirst, Identity, Join
from imoveis.processors import ParseDate, ParseDecimal

class ImovelLoader(XPathItemLoader):
  default_output_processor = TakeFirst()

  imagens_out = Identity()

  areas_comuns_out = Join(', ')
  condicoes_comerciais_out = Join(', ')
  outros_itens_out = Join(', ')
  telefones_out = Join(', ')

  valor_condominio_out = ParseDecimal()
  valor_venda_out = ParseDecimal()
  valor_aluguel_out = ParseDecimal()
  valor_m2_out = ParseDecimal()

  data_publicacao_out = ParseDate()