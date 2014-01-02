module Audit
  class Activity < ActiveRecord::Base
    establish_connection Audit::CONF

    after_commit :manage_db

    private
    def manage_db
      return if Audit::Activity.count < Audit::CONF[:threshold_limit]
      archive_count = Dir.glob("db/#{Audit::DB_NAME}_*.sqlite3").count
      File.rename("db/#{Audit::DB_NAME}.sqlite3", "db/#{Audit::DB_NAME}_#{archive_count + 1}.sqlite3") # Raname filled DB.
      Audit::Db.setup
      self.class.reconnect_audit
    end

    def self.reconnect_audit
      Audit::Activity.establish_connection Audit::CONF
    end

    def self.archived_count
      Dir.glob("db/#{Audit::DB_NAME}_*.sqlite3").count
    end

    def self.define_and_setup_connection(dynamic_model, archive_count)
      unless Object.const_defined?(dynamic_model)
        Object.const_set(dynamic_model, Class.new(ActiveRecord::Base) {
          self.table_name = Audit::TABLE_NAME
        })
      end
      dynamic_model.constantize.establish_connection(Audit::CONF.merge(:database => "db/#{Audit::DB_NAME}_#{archive_count}.sqlite3"))
    end

  end
end

