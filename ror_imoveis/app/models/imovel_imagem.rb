class ImovelImagem < ActiveRecord::Base
  belongs_to :imovel
  attr_accessible :url, :imovel
end
