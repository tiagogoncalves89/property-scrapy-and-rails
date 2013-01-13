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

  create_table "imoveis", :force => true do |t|
    t.boolean  "aluguel"
    t.boolean  "venda"
    t.decimal  "valor_aluguel",        :precision => 10, :scale => 0
    t.decimal  "valor_condominio",     :precision => 10, :scale => 0
    t.decimal  "valor_venda",          :precision => 10, :scale => 0
    t.decimal  "valor_m2",             :precision => 10, :scale => 0
    t.integer  "numero_suites"
    t.integer  "numero_vagas"
    t.integer  "dormitorios"
    t.integer  "andares"
    t.integer  "ano_construcao"
    t.integer  "area_util"
    t.text     "descricao"
    t.string   "url"
    t.string   "tipo"
    t.string   "localizacao"
    t.string   "uf"
    t.string   "cidade"
    t.string   "bairro"
    t.string   "rua"
    t.string   "anunciante"
    t.string   "creci"
    t.text     "areas_comuns"
    t.text     "condicoes_comerciais"
    t.text     "outros_itens"
    t.string   "telefones"
    t.date     "data_publicacao"
    t.integer  "imovel_site_id"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  add_index "imoveis", ["andares"], :name => "index_imoveis_on_andares"
  add_index "imoveis", ["ano_construcao"], :name => "index_imoveis_on_ano_construcao"
  add_index "imoveis", ["anunciante"], :name => "index_imoveis_on_anunciante"
  add_index "imoveis", ["area_util"], :name => "index_imoveis_on_area_util"
  add_index "imoveis", ["bairro"], :name => "index_imoveis_on_bairro"
  add_index "imoveis", ["cidade"], :name => "index_imoveis_on_cidade"
  add_index "imoveis", ["creci"], :name => "index_imoveis_on_creci"
  add_index "imoveis", ["data_publicacao"], :name => "index_imoveis_on_data_publicacao"
  add_index "imoveis", ["dormitorios"], :name => "index_imoveis_on_dormitorios"
  add_index "imoveis", ["localizacao"], :name => "index_imoveis_on_localizacao"
  add_index "imoveis", ["numero_suites"], :name => "index_imoveis_on_numero_suites"
  add_index "imoveis", ["numero_vagas"], :name => "index_imoveis_on_numero_vagas"
  add_index "imoveis", ["rua"], :name => "index_imoveis_on_rua"
  add_index "imoveis", ["tipo"], :name => "index_imoveis_on_tipo"
  add_index "imoveis", ["uf"], :name => "index_imoveis_on_uf"
  add_index "imoveis", ["url"], :name => "index_imoveis_on_url", :unique => true
  add_index "imoveis", ["valor_aluguel"], :name => "index_imoveis_on_valor_aluguel"
  add_index "imoveis", ["valor_condominio"], :name => "index_imoveis_on_valor_condominio"
  add_index "imoveis", ["valor_m2"], :name => "index_imoveis_on_valor_m2"
  add_index "imoveis", ["valor_venda"], :name => "index_imoveis_on_valor_venda"

  create_table "imovel_imagens", :force => true do |t|
    t.string   "url"
    t.integer  "imovel_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "imovel_sites", :force => true do |t|
    t.string   "nome"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "imovel_sites", ["nome"], :name => "index_imovel_sites_on_nome", :unique => true
  add_index "imovel_sites", ["url"], :name => "index_imovel_sites_on_url", :unique => true

end
