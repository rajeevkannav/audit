# Todo Get Action Name Update/Create/Destroy on def audit
# Todo #skip_audit_for  - Substract those columns which are expected to skip
# Todo audit/constants should be avaliable via YAML OR configurable by Rails environment variables
# Todo Code Review
# Todo Publish and Test with projects

require "audit/constants"
require "audit/engine"
require "audit/auditor"
require "audit/db"

module Audit
  extend ActiveSupport::Concern
  included do
    after_commit :audit
  end

  def audit
    ActiveSupport::Notifications.instrument('audit', {
        :event_name => self.class.name.split("::").last,
        :audited_object => self,
        :current_user => Thread.current[:user]}) do
    end
  end

  Audit::Db.setup
end

