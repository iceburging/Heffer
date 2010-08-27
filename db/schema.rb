# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100803145507) do

  create_table "categories", :force => true do |t|
    t.integer  "position"
    t.string   "title"
    t.text     "blurb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "iso_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries_shipping_methods", :id => false, :force => true do |t|
    t.integer "country_id"
    t.integer "shipping_method_id"
  end

  create_table "flags", :force => true do |t|
    t.integer  "position"
    t.string   "title"
    t.text     "blurb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "flags_product_lines", :id => false, :force => true do |t|
    t.integer "flag_id"
    t.integer "product_line_id"
  end

  create_table "images", :force => true do |t|
    t.string   "title"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", :force => true do |t|
    t.string   "name"
    t.string   "telephone"
    t.string   "contact"
    t.string   "account"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_entries", :force => true do |t|
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "news_items", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", :force => true do |t|
    t.integer  "product_line_id"
    t.string   "size"
    t.string   "colour"
    t.boolean  "available"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "order_ref"
    t.string   "ip_address"
    t.string   "status"
    t.string   "transaction_type"
    t.text     "cart"
    t.text     "shipping_method"
    t.string   "billing_firstname"
    t.string   "billing_lastname"
    t.string   "billing_line1"
    t.string   "billing_line2"
    t.string   "billing_town"
    t.string   "billing_county"
    t.string   "billing_country"
    t.string   "billing_postcode"
    t.string   "billing_email"
    t.string   "billing_telephone_number"
    t.string   "delivery_firstname"
    t.string   "delivery_lastname"
    t.string   "delivery_line1"
    t.string   "delivery_line2"
    t.string   "delivery_town"
    t.string   "delivery_county"
    t.string   "delivery_country"
    t.string   "delivery_postcode"
    t.text     "enrollment_check_response"
    t.text     "authenticate_response"
    t.text     "authorize_response"
    t.text     "capture_response"
    t.text     "void_response"
    t.text     "credit_response"
    t.datetime "enrollment_check_called_at"
    t.datetime "authenticate_called_at"
    t.datetime "authorize_called_at"
    t.datetime "capture_called_at"
    t.datetime "void_called_at"
    t.datetime "dispatch_called_at"
    t.datetime "credit_called_at"
    t.decimal  "order_credit"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "discount_value",             :precision => 10, :scale => 2
    t.string   "discount_description"
  end

  create_table "pages", :force => true do |t|
    t.integer  "menu_entry_id"
    t.string   "title"
    t.integer  "position"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "photos", :force => true do |t|
    t.integer  "product_line_id"
    t.integer  "position"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_lines", :force => true do |t|
    t.integer  "manufacturer_id"
    t.integer  "category_id"
    t.string   "mfr_prod_no"
    t.text     "notes"
    t.string   "range"
    t.string   "name"
    t.text     "description"
    t.text     "tag_line"
    t.string   "prod_no"
    t.string   "fabric"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shipping_methods", :force => true do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_hash"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
