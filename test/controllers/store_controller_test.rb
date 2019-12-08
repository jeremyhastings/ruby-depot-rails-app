require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    # Added extra test lines on December 8th, 2019.
    # This test looks for a nav element with the class side_nav and that there are at least 4 present.
    assert_select 'nav.side_nav a', minimum: 4
    # These lines verify that the products are being displayed.
    assert_select 'main ul.catalog li', 3
    assert_select 'h2', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
