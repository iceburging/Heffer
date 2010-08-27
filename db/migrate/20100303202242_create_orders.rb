class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :order_ref
      t.string :ip_address
      t.string :status
      t.string :transaction_type
      t.text :cart
      t.text :shipping_method
      t.string :billing_firstname
      t.string :billing_lastname
      t.string :billing_line1
      t.string :billing_line2
      t.string :billing_town
      t.string :billing_county
      t.string :billing_country
      t.string :billing_postcode
      t.string :billing_email
      t.string :billing_telephone_number
      t.string :delivery_firstname
      t.string :delivery_lastname
      t.string :delivery_line1
      t.string :delivery_line2
      t.string :delivery_town
      t.string :delivery_county
      t.string :delivery_country
      t.string :delivery_postcode
      t.text :enrollment_check_response
      t.text :authenticate_response
      t.text :authorize_response
      t.text :capture_response
      t.text :void_response
      t.text :credit_response
      t.datetime :enrollment_check_called_at
      t.datetime :authenticate_called_at
      t.datetime :authorize_called_at
      t.datetime :capture_called_at
      t.datetime :void_called_at
      t.datetime :dispatch_called_at
      t.datetime :credit_called_at
      t.decimal :order_credit, :precision => 10, :scale => 2
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end

