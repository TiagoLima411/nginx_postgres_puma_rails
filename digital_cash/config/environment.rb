# Load the Rails application.
require_relative 'application'

require File.expand_path('../application', __FILE__)

# if Rails.env.production?
#   require 'active_record/connection_adapters/mysql2_adapter'
#   module ActiveRecord
#     module ConnectionAdapters
#       class Mysql2Adapter
#         def create_table(table_name, options = {}) #:nodoc:
#           super(table_name, options.merge(:options => "ENGINE=NDB"))
#         end
#       end
#     end
#   end
# end

# Initialize the Rails application.
Rails.application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end
