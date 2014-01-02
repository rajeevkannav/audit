module Audit
  DYNAMIC_MODEL_CHAIN_NAME = 'AuditActivity'
  TABLE_NAME = DYNAMIC_MODEL_CHAIN_NAME.tableize
  DB_NAME = "#{Rails.env}_#{TABLE_NAME}"
  CONF = {
      :adapter => 'sqlite3',
      :database => "db/#{DB_NAME}.sqlite3",
      :threshold_limit => 5
  }
end