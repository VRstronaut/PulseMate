require 'test_helper'

class WoodsidePortalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get woodside_portal_index_url
    assert_response :success
  end

end
