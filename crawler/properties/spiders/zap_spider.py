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
from properties.items import PropertyItem
from properties.item_loaders import PropertyLoader

from scrapy.utils.sitemap import Sitemap

class ZapSpider(SitemapSpider):
  name = 'zap'
  sitemap_urls = ['http://www.zap.com.br/sitemap_index.xml']
  sitemap_rules = [
    ('imoveis/.*/(id|ID)-([0-9]+)$', 'parse_item')
  ]

  def parse_item(self, response):
    log.msg("parsing item", log.DEBUG)
    hxs = HtmlXPathSelector(response)

    inativo = len(hxs.select('//*[@id="ctl00_ContentPlaceHolder1_msgFichaInativa"]/div[1]/div').extract()) > 0
    apagado = len(hxs.select('//*[@id="ctl00_ContentPlaceHolder1_divMensagemAlerta"]/p').extract()) > 0

    if not inativo and not apagado and response.status == 200:
      loader = PropertyLoader(item=PropertyItem(), response = response)
      loader.add_value('url', response.url)
      loader.add_xpath('type_of_property', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[1]/h1/span[1]/text()')
      loader.add_xpath('rent_value', '//*[@id="ctl00_ContentPlaceHolder1_resumo_divAluguel"]/p[2]/text()', re = "([0-9\.,]+)$")
      loader.add_xpath('maintenance_value', '//*[@id="ctl00_ContentPlaceHolder1_resumo_liCondominio"]/span[2]/text()', re = "([0-9\.,]+)$")
      loader.add_xpath('sell_value', '//*[@id="ctl00_ContentPlaceHolder1_resumo_divValor"]/p[2]/text()', re = "([0-9\.,]+)$")
      loader.add_xpath('square_meter', '//*[@id="ctl00_ContentPlaceHolder1_resumo_liValorM2"]/span[2]/text()', re = "([0-9\.,]+)$")
      loader.add_xpath('number_of_suites', '//*[@id="ctl00_ContentPlaceHolder1_resumo_liQtdSuites"]/span[2]/text()', re = "^([0-9]+)")
      loader.add_xpath('number_of_parking_space', '//*[@id="ctl00_ContentPlaceHolder1_resumo_liQtdVagas"]/span[2]/text()', re = "^([0-9]+)")
      loader.add_xpath('bedroom', '//*[@id="ctl00_ContentPlaceHolder1_detalhes_lbDorms"]/text()', re = "^([0-9]+)")
      loader.add_xpath('floors', '//*[@id="ctl00_ContentPlaceHolder1_detalhes_lbAndar"]/text()', re = "^([0-9]+)")
      loader.add_xpath('built_year', '//*[@id="ctl00_ContentPlaceHolder1_detalhes_lbConstrucao"]/text()')
      loader.add_xpath('area', '//*[@id="ctl00_ContentPlaceHolder1_resumo_liAreaM2"]/span[2]/text()', re = "^([0-9]+)")
      loader.add_xpath('description', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[1]/div[7]/h3/text()')
      loader.add_xpath('location', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[1]/h1/span[2]/text()')
      loader.add_xpath('neighborhood', '//*[@id="divReputacaoBairro"]/h4/span/text()')
      loader.add_xpath('street', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[1]/h1/span[3]/text()')
      loader.add_xpath('agent', '//*[@id="ctl00_ContentPlaceHolder1_contatelateral_planunciante"]/div[2]/h4/text()')
      loader.add_xpath('creci', '//*[@id="ctl00_ContentPlaceHolder1_contatelateral_pCreci"]/text()', re = "([0-9a-zA-Z ]+)$")
      loader.add_xpath('common_area', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[3]/div[1]/ul/li/text()')
      loader.add_xpath('trade_terms', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[5]/div[2]/ul/li/text()')
      loader.add_xpath('other_things', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[5]/div[1]/ul/li/text()')
      loader.add_xpath('phones', '//*[@id="ctl00_ContentPlaceHolder1_vertelefones"]/div[3]/div/span/text()')
      loader.add_xpath('images', '//*[@id="galleria"]/a/@href')
      loader.add_xpath('publish_date', '//*[@id="zapGeral"]/div/div[4]/div[3]/div[1]/div/span[1]/text()', re = "([0-9/]+)$")
      loader.add_xpath('state', '//*[@id="zapGeral"]/div/div[4]/div[3]/div/script[1]/text()', re = "var UF='([^']+)';")
      loader.add_xpath('city', '//*[@id="zapGeral"]/div/div[4]/div[3]/div/script[1]/text()', re = "var cidade='([^']+)';")

      return loader.load_item()

  def __init__(self):
    log.msg("Connecting in database", log.DEBUG)
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
              rows = self.cursor.execute("SELECT id FROM properties WHERE url = %s", loc)
              if rows == 0:
                yield Request(loc, callback=c)
                break

def extrair_url(it):
  for d in it:
    yield d['loc']