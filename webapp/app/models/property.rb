class Property < ActiveRecord::Base

  has_many :property_images, :dependent => :destroy
  belongs_to :property_source
  attr_accessible :floors, :built_year, :agent, :area, :common_area, :neighborhood, :city, :trade_terms, :creci, :publish_date, :description, :bedroom, :images, :location, :number_of_suites, :number_of_parking_space, :other_things, :street, :phones, :type_of_property, :state, :rent_value, :maintenance_value, :square_meter, :sell_value, :url, :rent, :sell

end