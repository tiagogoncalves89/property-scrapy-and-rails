class CreateImovelSites < ActiveRecord::Migration

  def change
    create_table :imovel_sites do |t|
      t.string :nome
      t.string :url

      t.timestamps
    end

    add_index :imovel_sites, :nome, :unique => true
    add_index :imovel_sites, :url, :unique => true
  end

end