class CreateImovelImagens < ActiveRecord::Migration
  def change
    create_table :imovel_imagens do |t|
      t.string :url

      t.timestamps
    end
  end
end
