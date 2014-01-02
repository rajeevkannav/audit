class Post < ActiveRecord::Base
  include Audit
  #skip_audit_for :id
end
