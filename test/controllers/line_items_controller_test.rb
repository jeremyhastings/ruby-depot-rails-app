require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_url
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      # Updated line on December 9th, 2019 to reflect cart being a session.
      post line_items_url, params: { product_id: products(:ruby).id }
      #post line_items_url, params: { line_item: { cart_id: @line_item.cart_id, product_id: @line_item.product_id } }


    end

    follow_redirect!

    # Added Assert lines to test new cart styles.  December 9th, 2019.
    assert_select 'h2', 'Your Cart'
    assert_select 'td', "Programming Ruby 1.9"

    #assert_redirected_to line_item_url(LineItem.last)
  end

  test "should show line_item" do
    get line_item_url(@line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test "should update line_item" do
    # Added new line to handle the removal of the cart_id as a parameter to controller.  December 9th, 2019.
    patch line_item_url(@line_item), params: { line_item: { product_id: @line_item.product.id } }
    #patch line_item_url(@line_item), params: { line_item: { cart_id: @line_item.cart_id, product_id: @line_item.product_id } }
    assert_redirected_to line_item_url(@line_item)
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to line_items_url
  end
end
