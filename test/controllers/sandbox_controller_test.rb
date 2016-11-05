require 'test_helper'

class SandboxControllerTest < ActionController::TestCase
  test "should get product" do
    get :product
    assert_response :success
  end

end
