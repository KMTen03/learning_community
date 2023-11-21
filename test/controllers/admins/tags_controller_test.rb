require "test_helper"

class Admins::TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_tags_index_url
    assert_response :success
  end

  test "should get edit" do
    get admins_tags_edit_url
    assert_response :success
  end
end
