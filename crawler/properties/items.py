# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/topics/items.html

from scrapy.item import Item, Field

class PropertyItem(Item):
  rent_value = Field()
  maintenance_value = Field()
  sell_value = Field()
  square_meter = Field()
  number_of_suites = Field()
  number_of_parking_space = Field()
  bedroom = Field()
  floors = Field()
  built_year = Field()
  area = Field()
  description = Field()
  type_of_property = Field()
  location = Field()
  state = Field()
  city = Field()
  neighborhood = Field()
  street = Field()
  agent = Field()
  creci = Field()
  common_area = Field()
  trade_terms = Field()
  other_things = Field()
  phones = Field()
  images = Field()
  publish_date = Field()
  url = Field()