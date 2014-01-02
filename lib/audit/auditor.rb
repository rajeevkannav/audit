module Audit

  def padded_audit
    begin
      if self.class.respond_to? :skip_audit_for
        self.previous_changes
      else
        self.previous_changes.to_s
      end
    rescue Exception => error
      {fail: "No audit data available for #{self.class.name}", message: error.message, elog: error.backtrace}
    end
  end

  module Auditor
    ActiveSupport::Notifications.subscribe('audit') do |*args|
      data = args.last
      audited_data = {
          audited_class: data[:event_name],
          audit_action: data[:audit_action],
          audited_data: data[:audited_object].padded_audit,
          audited_by: data[:current_user],
      }
      Audit::Activity.create! audited_data
    end
  end
end

