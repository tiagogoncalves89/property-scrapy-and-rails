class CreatePropertySources < ActiveRecord::Migration

  def change
    create_table :property_sources do |t|
      t.string :nome
      t.string :url

      t.timestamps
    end

    add_index :property_sources, :nome, :unique => true
    add_index :property_sources, :url, :unique => true
  end

end