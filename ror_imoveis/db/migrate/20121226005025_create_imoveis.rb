class CreateImoveis < ActiveRecord::Migration

  def change
    create_table :imoveis do |t|
      t.decimal :valor_aluguel
      t.decimal :valor_condominio
      t.decimal :valor_venda
      t.decimal :valor_m2
      t.integer :numero_suites
      t.integer :numero_vagas
      t.integer :dormitorios
      t.integer :andares
      t.integer :ano_construcao
      t.integer :area_util
      t.text :descricao
      t.string :url
      t.string :tipo
      t.string :localizacao
      t.string :uf
      t.string :cidade
      t.string :bairro
      t.string :rua
      t.string :anunciante
      t.string :creci
      t.string :areas_comuns
      t.string :condicoes_comerciais
      t.string :outros_itens
      t.string :telefones
      t.date :data_publicacao

      t.timestamps     
    end

    add_index :imoveis, :url, :unique => true
    add_index :imoveis, :valor_aluguel
    add_index :imoveis, :valor_condominio
    add_index :imoveis, :valor_venda
    add_index :imoveis, :valor_m2
    add_index :imoveis, :numero_suites
    add_index :imoveis, :numero_vagas
    add_index :imoveis, :dormitorios
    add_index :imoveis, :andares
    add_index :imoveis, :ano_construcao
    add_index :imoveis, :area_util
    add_index :imoveis, :tipo
    add_index :imoveis, :localizacao
    add_index :imoveis, :uf
    add_index :imoveis, :cidade
    add_index :imoveis, :bairro
    add_index :imoveis, :rua
    add_index :imoveis, :anunciante
    add_index :imoveis, :creci
    add_index :imoveis, :areas_comuns
    add_index :imoveis, :condicoes_comerciais
    add_index :imoveis, :outros_itens
    add_index :imoveis, :telefones
    add_index :imoveis, :data_publicacao 
  end

end