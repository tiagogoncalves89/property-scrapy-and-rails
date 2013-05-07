class PropertyImage < ActiveRecord::Base
  belongs_to :property
  attr_accessible :url
end