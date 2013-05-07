class PropertySource < ActiveRecord::Base
  has_many :property, :dependent => :destroy
  attr_accessible :nome, :url
end