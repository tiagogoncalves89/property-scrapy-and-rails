# Scrapy settings for properties project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/topics/settings.html
#

BOT_NAME = 'properties'

SPIDER_MODULES = ['properties.spiders']
NEWSPIDER_MODULE = 'properties.spiders'

# Crawl responsibly by identifying yourself (and your website) on the user-agent
USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11'

LOG_LEVEL = 'INFO'
LOGS_ENABLED = True

ITEM_PIPELINES = [
  'properties.pipelines.DefaultValuesPipeline',
  'properties.pipelines.MySQLStorePipeline'
]

COOKIES_ENABLED = False
REDIRECT_MAX_TIMES = 0

# Database connection information
DATABASE_HOST = '192.168.33.10'
DATABASE_NAME = 'ror_properties_development'
DATABASE_USER = 'root'
DATABASE_PASSWORD = ''

CONCURRENT_ITEMS = 30
CONCURRENT_REQUESTS = 8
CONCURRENT_REQUESTS_PER_DOMAIN = 8

DOWNLOADER_STATS = True