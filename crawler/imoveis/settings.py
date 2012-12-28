# Scrapy settings for imoveis project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/topics/settings.html
#

BOT_NAME = 'imoveis'

SPIDER_MODULES = ['imoveis.spiders']
NEWSPIDER_MODULE = 'imoveis.spiders'

# Crawl responsibly by identifying yourself (and your website) on the user-agent
USER_AGENT = 'Mozilla/6.0 (Windows NT 6.2; WOW64; rv:16.0.1) Gecko/20121011 Firefox/16.0.1'

LOG_LEVEL = 'INFO'

ITEM_PIPELINES = [
  'imoveis.pipelines.DefaultValuesPipeline',
  'imoveis.pipelines.MySQLStorePipeline'
]

# Database connection information
DATABASE_HOST = '192.168.33.10'
DATABASE_NAME = 'ror_imoveis_development'
DATABASE_USER = 'root'
DATABASE_PASSWORD = ''