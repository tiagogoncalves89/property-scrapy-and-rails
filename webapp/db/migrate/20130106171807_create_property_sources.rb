class CreatePropertySources < ActiveRecord::Migration

  def change
    create_table :property_sources do |t|
      t.string :name
      t.string :url

      t.timestamps
    end

    add_index :property_sources, :name, :unique => true
    add_index :property_sources, :url, :unique => true
  end

end