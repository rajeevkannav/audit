require_dependency "audit/application_controller"

module Audit
  class AuditActivitiesController < ApplicationController

    def index
      if params[:archive].nil? or params[:archive] == 0 or !File.exist?("db/#{Audit::DB_NAME}_#{params[:archive]}.sqlite3")
        Audit::Activity.reconnect_audit
        @activities = Audit::Activity.all
      else
        dynamic_model = "#{Audit::DYNAMIC_MODEL_CHAIN_NAME}#{params[:archive]}"
        Audit::Activity.define_and_setup_connection(dynamic_model, params[:archive])
        @activities = dynamic_model.constantize.all
      end
      @archived = Audit::Activity.archived_count
    end

  end
end