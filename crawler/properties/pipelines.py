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
    log.msg("Setting default values of item", log.DEBUG)

    item.setdefault('rent_value', None)
    item.setdefault('maintenance_value', None)
    item.setdefault('sell_value', None)
    item.setdefault('square_meter', None)
    item.setdefault('number_of_suites', 0)
    item.setdefault('number_of_parking_space', 0)
    item.setdefault('bedroom', 0)
    item.setdefault('floors', None)
    item.setdefault('built_year', None)
    item.setdefault('area', None)
    item.setdefault('description', '')
    item.setdefault('type_of_property', '')
    item.setdefault('location', '')
    item.setdefault('state', '')
    item.setdefault('city', '')
    item.setdefault('neighborhood', '')
    item.setdefault('street', '')
    item.setdefault('agent', '')
    item.setdefault('creci', '')
    item.setdefault('common_area', '')
    item.setdefault('trade_terms', '')
    item.setdefault('other_things', '')
    item.setdefault('phones', '')
    item.setdefault('images', [])
    item.setdefault('publish_date', '')
    item.setdefault('url', '')

    return item

class MySQLStorePipeline(object):

  def __init__(self):
    log.msg("connecting in database", log.DEBUG)

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
    log.msg("processing item in MySQLStorePipeline", log.DEBUG)
    query = self.dbpool.runInteraction(self._insert, item)

    return item

  def _insert(self, tx, item):
    log.msg("inserting item in database", log.DEBUG)
    try:
      rent = False
      if item['rent_value'] > 0:
        rent = True

      sell = False
      if item['sell_value'] > 0:
        sell = True

      tx.execute("INSERT IGNORE INTO `properties`\
        (rent_value, maintenance_value, sell_value, square_meter, number_of_suites, number_of_parking_space, bedroom, floors, built_year, \
          area, description, type_of_property, location, state, city, neighborhood, street, agent, creci, common_area, trade_terms, other_things, \
          phones, publish_date, url, rent, sell, property_source_id, created_at, updated_at)\
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 1, now(), now())", (
          item['rent_value'],
          item['maintenance_value'],
          item['sell_value'],
          item['square_meter'],
          item['number_of_suites'],
          item['number_of_parking_space'],
          item['bedroom'],
          item['floors'],
          item['built_year'],
          item['area'],
          item['description'],
          item['type_of_property'],
          item['location'],
          item['state'],
          item['city'],
          item['neighborhood'],
          item['street'],
          item['agent'],
          item['creci'],
          item['common_area'],
          item['trade_terms'],
          item['other_things'],
          item['phones'],
          item['publish_date'],
          item['url'],
          rent,
          sell
        )
      )

      property_id = tx.lastrowid
      if property_id > 0:
        for image in item['images']:
          tx.execute("INSERT INTO `property_images`\
            (url, property_id, created_at, updated_at)\
              VALUES (%s, %s, now(), now())", (
                image,
                property_id
              ))

    except MySQLdb.Error, e:
      log.msg(("Error %d: %s" % (e.args[0], e.args[1])), log.ERROR)