require 'test_helper'

module Audit
  class AuditActivitiesControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end

  end
end
