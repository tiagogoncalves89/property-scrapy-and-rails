from scrapy.contrib.loader import XPathItemLoader
from scrapy.contrib.loader.processor import TakeFirst, Identity, Join
from imoveis.processors import ParseDate, ParseDecimalEnd, ParseIntegerStart, ParseCreci

class ImovelLoader(XPathItemLoader):
  default_output_processor = TakeFirst()

  creci_out = ParseCreci()
  valor_condominio_out = ParseDecimalEnd()
  valor_venda_out = ParseDecimalEnd()
  valor_aluguel_out = ParseDecimalEnd()
  valor_m2_out = ParseDecimalEnd()
  numero_suites_out = ParseIntegerStart()
  andares_out = ParseIntegerStart()
  area_util_out = ParseIntegerStart()
  numero_vagas_out = ParseIntegerStart()
  dormitorios_out = ParseIntegerStart()
  data_publicacao_out = ParseDate()
  areas_comuns_out = Join(', ')
  condicoes_comerciais_out = Join(', ')
  outros_itens_out = Join(', ')
  telefones_out = Join(', ')
  imagens_out = Identity()