# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130106171807) do

  create_table "properties", :force => true do |t|
    t.boolean  "rent"
    t.boolean  "sell"
    t.decimal  "rent_value",              :precision => 10, :scale => 0
    t.decimal  "maintenance_value",       :precision => 10, :scale => 0
    t.decimal  "sell_value",              :precision => 10, :scale => 0
    t.decimal  "square_meter",            :precision => 10, :scale => 0
    t.integer  "number_of_suites"
    t.integer  "number_of_parking_space"
    t.integer  "bedroom"
    t.integer  "floors"
    t.integer  "built_year"
    t.integer  "area"
    t.text     "description"
    t.string   "url"
    t.string   "type_of_property"
    t.string   "location"
    t.string   "state"
    t.string   "city"
    t.string   "neighborhood"
    t.string   "street"
    t.string   "agent"
    t.string   "creci"
    t.text     "common_area"
    t.text     "trade_terms"
    t.text     "other_things"
    t.string   "phones"
    t.date     "publish_date"
    t.integer  "property_source_id"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  add_index "properties", ["agent"], :name => "index_properties_on_agent"
  add_index "properties", ["area"], :name => "index_properties_on_area"
  add_index "properties", ["bedroom"], :name => "index_properties_on_bedroom"
  add_index "properties", ["built_year"], :name => "index_properties_on_built_year"
  add_index "properties", ["city"], :name => "index_properties_on_city"
  add_index "properties", ["creci"], :name => "index_properties_on_creci"
  add_index "properties", ["floors"], :name => "index_properties_on_floors"
  add_index "properties", ["location"], :name => "index_properties_on_location"
  add_index "properties", ["maintenance_value"], :name => "index_properties_on_maintenance_value"
  add_index "properties", ["neighborhood"], :name => "index_properties_on_neighborhood"
  add_index "properties", ["number_of_parking_space"], :name => "index_properties_on_number_of_parking_space"
  add_index "properties", ["number_of_suites"], :name => "index_properties_on_number_of_suites"
  add_index "properties", ["publish_date"], :name => "index_properties_on_publish_date"
  add_index "properties", ["rent_value"], :name => "index_properties_on_rent_value"
  add_index "properties", ["sell_value"], :name => "index_properties_on_sell_value"
  add_index "properties", ["square_meter"], :name => "index_properties_on_square_meter"
  add_index "properties", ["state"], :name => "index_properties_on_state"
  add_index "properties", ["street"], :name => "index_properties_on_street"
  add_index "properties", ["type_of_property"], :name => "index_properties_on_type_of_property"
  add_index "properties", ["url"], :name => "index_properties_on_url", :unique => true

  create_table "property_images", :force => true do |t|
    t.string   "url"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "property_sources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "property_sources", ["name"], :name => "index_property_sources_on_name", :unique => true
  add_index "property_sources", ["url"], :name => "index_property_sources_on_url", :unique => true

end
