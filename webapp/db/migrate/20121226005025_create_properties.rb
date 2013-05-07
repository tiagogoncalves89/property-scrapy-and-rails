class CreateProperties < ActiveRecord::Migration

  def change
    create_table :properties do |t|
      t.boolean :aluguel
      t.boolean :venda
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
      t.text :areas_comuns
      t.text :condicoes_comerciais
      t.text :outros_itens
      t.string :telefones
      t.date :data_publicacao
      t.references :property_source

      t.timestamps
    end

    add_index :properties, :url, :unique => true
    add_index :properties, :valor_aluguel
    add_index :properties, :valor_condominio
    add_index :properties, :valor_venda
    add_index :properties, :valor_m2
    add_index :properties, :numero_suites
    add_index :properties, :numero_vagas
    add_index :properties, :dormitorios
    add_index :properties, :andares
    add_index :properties, :ano_construcao
    add_index :properties, :area_util
    add_index :properties, :tipo
    add_index :properties, :localizacao
    add_index :properties, :uf
    add_index :properties, :cidade
    add_index :properties, :bairro
    add_index :properties, :rua
    add_index :properties, :anunciante
    add_index :properties, :creci
    add_index :properties, :data_publicacao
  end

end