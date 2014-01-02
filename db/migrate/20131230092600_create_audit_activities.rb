class CreateAuditActivities < ActiveRecord::Migration
  def change
    create_table :audit_activities do |t|
      t.string :audited_class
      t.string :audit_action
      t.string :audited_data
      t.string :audited_by

      t.timestamps
    end
  end
end
