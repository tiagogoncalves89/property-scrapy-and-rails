class CreatePropertyImages < ActiveRecord::Migration

  def change
    create_table :property_images do |t|
      t.string :url
      t.references :property

      t.timestamps
    end
  end

end