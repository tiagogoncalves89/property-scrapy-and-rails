from scrapy.contrib.loader import XPathItemLoader
from scrapy.contrib.loader.processor import TakeFirst, Identity, Join
from properties.processors import ParseDate, ParseDecimal

class PropertyLoader(XPathItemLoader):
  default_output_processor = TakeFirst()

  images_out = Identity()

  common_area_out = Join(', ')
  trade_terms_out = Join(', ')
  other_things_out = Join(', ')
  phones_out = Join(', ')

  maintenance_value_out = ParseDecimal()
  sell_value_out = ParseDecimal()
  rent_value_out = ParseDecimal()
  square_meter_out = ParseDecimal()

  publish_date_out = ParseDate()