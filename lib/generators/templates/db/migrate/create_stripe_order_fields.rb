class CreateStripeOrderFieldsFor<%= order_table_name.camelize.pluralize %> < ActiveRecord::Migration
  def change
    add_column :<%= order_table_name.downcase.pluralize %>, :stripe_charge_id, :string, unique: true, index: true
    add_column :<%= order_table_name.downcase.pluralize %>, :stripe_card_token, :string, unique: true, index: true
  end
end
