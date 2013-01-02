# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/topics/item-pipeline.html

import MySQLdb.cursors
import re
from scrapy import log
from scrapy.conf import settings
from twisted.enterprise import adbapi

class DefaultValuesPipeline(object):

    def process_item(self, item, spider):
      item.setdefault('ano_construcao', None)

      item.setdefault('valor_aluguel', None)
      item.setdefault('valor_condominio', None)
      item.setdefault('valor_venda', None)
      item.setdefault('valor_m2', None)
      item.setdefault('numero_suites', 0)
      item.setdefault('numero_vagas', 0)
      item.setdefault('dormitorios', 0)
      item.setdefault('andares', None)
      item.setdefault('ano_construcao', None)
      item.setdefault('area_util', None)
      item.setdefault('descricao', '')
      item.setdefault('tipo', '')
      item.setdefault('localizacao', '')
      item.setdefault('uf', '')
      item.setdefault('cidade', '')
      item.setdefault('bairro', '')
      item.setdefault('rua', '')
      item.setdefault('anunciante', '')
      item.setdefault('creci', '')
      item.setdefault('areas_comuns', '')
      item.setdefault('condicoes_comerciais', '')
      item.setdefault('outros_itens', '')
      item.setdefault('telefones', '')
      item.setdefault('imagens', [])
      item.setdefault('data_publicacao', '')
      item.setdefault('url', '')

      return item

class MySQLStorePipeline(object):

  def __init__(self):
    self.dbpool = adbapi.ConnectionPool('MySQLdb',
      host = settings['DATABASE_HOST'],
      db = settings['DATABASE_NAME'],
      user = settings['DATABASE_USER'],
      passwd = settings['DATABASE_PASSWORD'],
      cursorclass = MySQLdb.cursors.DictCursor,
      charset = 'utf8',
      use_unicode = True
    )

  def process_item(self, item, spider):
    query = self.dbpool.runInteraction(self._insert, item)

    return item

  def _insert(self, tx, item):
    try:
      tx.execute("INSERT IGNORE INTO `imoveis`\
        (valor_aluguel, valor_condominio, valor_venda, valor_m2, numero_suites, numero_vagas, dormitorios, andares, ano_construcao, \
          area_util, descricao, tipo, localizacao, uf, cidade, bairro, rua, anunciante, creci, areas_comuns, condicoes_comerciais, outros_itens, \
          telefones, data_publicacao, url, created_at, updated_at)\
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, now(), now())", (
          item['valor_aluguel'],
          item['valor_condominio'],
          item['valor_venda'],
          item['valor_m2'],
          item['numero_suites'],
          item['numero_vagas'],
          item['dormitorios'],
          item['andares'],
          item['ano_construcao'],
          item['area_util'],
          item['descricao'],
          item['tipo'],
          item['localizacao'],
          item['uf'],
          item['cidade'],
          item['bairro'],
          item['rua'],
          item['anunciante'],
          item['creci'],
          item['areas_comuns'],
          item['condicoes_comerciais'],
          item['outros_itens'],
          item['telefones'],
          item['data_publicacao'],
          item['url']
        )
      )

      imovel_id = tx.lastrowid
      if imovel_id > 0:
        for imagem in item['imagens']:
          tx.execute("INSERT INTO `imovel_imagens`\
            (url, imovel_id, created_at, updated_at)\
              VALUES (%s, %s, now(), now())", (
                imagem,
                imovel_id
              ))
    except MySQLdb.Error, e:
      log.msg('URL DO ERRO: ' + str(item['url']), log.ERROR)
      log.msg(("Error %d: %s" % (e.args[0], e.args[1])), log.ERROR)