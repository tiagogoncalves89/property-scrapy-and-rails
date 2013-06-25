class CreateProperties < ActiveRecord::Migration

  def change
    create_table :properties do |t|
      t.boolean :rent
      t.boolean :sell
      t.decimal :rent_value
      t.decimal :maintenance_value
      t.decimal :sell_value
      t.decimal :square_meter
      t.integer :number_of_suites
      t.integer :number_of_parking_space
      t.integer :bedroom
      t.integer :floors
      t.integer :built_year
      t.integer :area
      t.text :description
      t.string :url
      t.string :type_of_property
      t.string :location
      t.string :state
      t.string :city
      t.string :neighborhood
      t.string :street
      t.string :agent
      t.string :creci
      t.text :common_area
      t.text :trade_terms
      t.text :other_things
      t.string :phones
      t.date :publish_date
      t.references :property_source

      t.timestamps
    end

    add_index :properties, :url, :unique => true
    add_index :properties, :rent_value
    add_index :properties, :maintenance_value
    add_index :properties, :sell_value
    add_index :properties, :square_meter
    add_index :properties, :number_of_suites
    add_index :properties, :number_of_parking_space
    add_index :properties, :bedroom
    add_index :properties, :floors
    add_index :properties, :built_year
    add_index :properties, :area
    add_index :properties, :type_of_property
    add_index :properties, :location
    add_index :properties, :state
    add_index :properties, :city
    add_index :properties, :neighborhood
    add_index :properties, :street
    add_index :properties, :agent
    add_index :properties, :creci
    add_index :properties, :publish_date
  end

end