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
USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11'

LOG_LEVEL = 'INFO'

ITEM_PIPELINES = [
  'imoveis.pipelines.DefaultValuesPipeline',
  'imoveis.pipelines.MySQLStorePipeline'
]

COOKIES_ENABLED = False
REDIRECT_MAX_TIMES = 0

# Database connection information
DATABASE_HOST = '192.168.30.10'
DATABASE_NAME = 'ror_imoveis_development'
DATABASE_USER = 'root'
DATABASE_PASSWORD = ''

CONCURRENT_ITEMS = 100
CONCURRENT_REQUESTS = 32
CONCURRENT_REQUESTS_PER_DOMAIN = 32