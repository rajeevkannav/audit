require 'active_record'
module Audit
  module Db
    def setup
      return if File.exist? "db/#{DB_NAME}.sqlite3"
      ActiveRecord::Base.establish_connection(CONF)
      `touch "db/#{DB_NAME}.sqlite3"`
      ActiveRecord::Schema.define do
        drop_table :audit_activities if ActiveRecord::Base.connection.tables.include? 'audit_activities'
        create_table :audit_activities do |t|
          t.string :audited_class
          t.string :audit_action
          t.string :audited_data
          t.string :audited_by
          t.timestamps
        end
      end
      default_config ||= YAML::load(IO.read(File.join('config', 'database.yml')))[Rails.env]
      ActiveRecord::Base.establish_connection(default_config)
    end

    module_function :setup
  end
end
