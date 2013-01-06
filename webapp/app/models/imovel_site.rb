class ImovelSite < ActiveRecord::Base
  has_many :imovel, :dependent => :destroy
  attr_accessible :nome, :url
end
