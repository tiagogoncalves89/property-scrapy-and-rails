# coding=utf-8

import re
import time
import MySQLdb.cursors
from scrapy.conf import settings
from scrapy.http import Request
from scrapy import log
from scrapy.contrib.spiders import SitemapSpider, Rule
from scrapy.selector import HtmlXPathSelector
from scrapy.contrib.loader import XPathItemLoader
from imoveis.items import ImovelItem
from imoveis.item_loaders import ImovelLoader

from scrapy.utils.sitemap import Sitemap

class ZapSpider(SitemapSpider):
  name = 'zap'
  sitemap_urls = ['http://www.zap.com.br/sitemap_index.xml']
  sitemap_rules = [
    ('imoveis/.*/(id|ID)-([0-9]+)$', 'parse_item')
  ]

  def parse_item(self, response):
    hxs = HtmlXPathSelector(response)

    inativo = len(hxs.select('//*[@id="ctl00_ContentPlaceHolder1_msgFichaInativa"]/div[1]/div').extract()) > 0
    apagado = len(hxs.select('//*[@id="ctl00_ContentPlaceHolder1_divMensagemAlerta"]/p').extract()) > 0

    if not inativo and not apagado and response.status == 200:
      loader = ImovelLoader(item=ImovelItem(), response = response)
      loader.add_value('url', response.url)
      loader.add_xpath('tipo', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[1]/h1/span[1]/text()')
      loader.add_xpath('valor_aluguel', '//*[@id="ctl00_ContentPlaceHolder1_resumo_divAluguel"]/p[2]/text()')
      loader.add_xpath('valor_condominio', '//*[@id="ctl00_ContentPlaceHolder1_resumo_liCondominio"]/span[2]/text()')
      loader.add_xpath('valor_venda', '//*[@id="ctl00_ContentPlaceHolder1_resumo_divValor"]/p[2]/text()')
      loader.add_xpath('valor_m2', '//*[@id="ctl00_ContentPlaceHolder1_resumo_liValorM2"]/span[2]/text()')
      loader.add_xpath('numero_suites', '//*[@id="ctl00_ContentPlaceHolder1_resumo_liQtdSuites"]/span[2]/text()')
      loader.add_xpath('numero_vagas', '//*[@id="ctl00_ContentPlaceHolder1_resumo_liQtdVagas"]/span[2]/text()')
      loader.add_xpath('dormitorios', '//*[@id="ctl00_ContentPlaceHolder1_detalhes_lbDorms"]/text()')
      loader.add_xpath('andares', '//*[@id="ctl00_ContentPlaceHolder1_detalhes_lbAndar"]/text()')
      loader.add_xpath('ano_construcao', '//*[@id="ctl00_ContentPlaceHolder1_detalhes_lbConstrucao"]/text()')
      loader.add_xpath('area_util', '//*[@id="ctl00_ContentPlaceHolder1_resumo_liAreaM2"]/span[2]/text()')
      loader.add_xpath('descricao', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[1]/div[7]/h3/text()')
      loader.add_xpath('localizacao', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[1]/h1/span[2]/text()')
      loader.add_xpath('bairro', '//*[@id="divReputacaoBairro"]/h4/span/text()')
      loader.add_xpath('rua', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[1]/h1/span[3]/text()')
      loader.add_xpath('anunciante', '//*[@id="ctl00_ContentPlaceHolder1_contatelateral_plAnunciante"]/div[2]/h4/text()')
      loader.add_xpath('creci', '//*[@id="ctl00_ContentPlaceHolder1_contatelateral_pCreci"]/text()')
      loader.add_xpath('areas_comuns', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[3]/div[1]/ul/li/text()')
      loader.add_xpath('condicoes_comerciais', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[5]/div[2]/ul/li/text()')
      loader.add_xpath('outros_itens', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[5]/div[1]/ul/li/text()')
      loader.add_xpath('telefones', '//*[@id="ctl00_ContentPlaceHolder1_vertelefones"]/div[3]/div/span/text()')
      loader.add_xpath('imagens', '//*[@id="galleria"]/a/@href')
      loader.add_xpath('data_publicacao', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[1]/div/span[1]/text()')

      # Extraindo informações de javascript
      for script in hxs.select('//*[@id="zapGeral"]/div/div[4]/div[3]/div/script[1]/text()').extract():
        uf = re.search("var UF='([^']+)';", script)
        if uf:
          loader.add_value('uf', uf.group(1))

        cidade = re.search("var Cidade='([^']+)';", script)
        if cidade:
          loader.add_value('cidade',cidade.group(1))

      return loader.load_item()

  def __init__(self):
    self.conn = MySQLdb.connect(
      user=settings['DATABASE_USER'], 
      passwd=settings['DATABASE_PASSWORD'], 
      db=settings['DATABASE_NAME'], 
      host=settings['DATABASE_HOST'], 
      charset="utf8", 
      use_unicode=True
    )

    self.cursor = self.conn.cursor()
    super(ZapSpider, self).__init__()

  def _parse_sitemap(self, response):
    if response.url.endswith('/robots.txt'):
      for url in sitemap_urls_from_robots(response.body):
        yield Request(url, callback=self._parse_sitemap)
    else:
      body = self._get_sitemap_body(response)
      if body is None:
        log.msg(format="Ignoring invalid sitemap: %(response)s", level=log.WARNING, spider=self, response=response)
        return

      s = Sitemap(body)
      if s.type == 'sitemapindex':
        for loc in extrair_url(s):
          if any(x.search(loc) for x in self._follow):
            yield Request(loc, callback=self._parse_sitemap)
      elif s.type == 'urlset':
        for loc in extrair_url(s):
          for r, c in self._cbs:
            if r.search(loc):
              rows = self.cursor.execute("SELECT id FROM imoveis WHERE url = %s", loc)
              if rows == 0:
                yield Request(loc, callback=c)
                break

def extrair_url(it):
  for d in it:
    yield d['loc']