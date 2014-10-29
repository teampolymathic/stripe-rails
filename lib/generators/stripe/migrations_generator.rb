require 'rails/generators/active_record'

# Thank you to FriendlyID for the generator template.
# https://github.com/norman/friendly_id/blob/master/lib/generators/friendly_id_generator.rb
# - @colinyoung

module Stripe
  class MigrationsGenerator < ::ActiveRecord::Generators::Base
    desc 'Generates the migrations needed for Stripe models.'
    argument :order_table_name, type: :string, default: 'Order', required: false
    argument :user_table_name, type: :string, default: 'User', required: false
    argument :name, type: :string, default: ''

    class_option :'skip-customers', :type => :boolean, :desc => "Don't generate customer fields"
    class_option :'skip-orders', :type => :boolean, :desc => "Don't generate order fields"
    # class_option :'skip-initializer', :type => :boolean, :desc => "Don't generate an initializer"

    source_root File.expand_path('../../templates/db/migrate', __FILE__)

    # Copies the migration template to db/migrate.
    def copy_files
      unless options['skip-orders']
        migration_template 'create_stripe_order_fields.rb', "db/migrate/create_stripe_order_fields_for_#{table_name}.rb"
      end

      unless options['skip-customers']
        migration_template 'create_stripe_customer_fields.rb', "db/migrate/create_stripe_customer_fields_for_#{user_table_name.downcase.pluralize}.rb"
      end
    end
  end
end
