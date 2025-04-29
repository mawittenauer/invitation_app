require "test_helper"

class InviteesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get invitees_new_url
    assert_response :success
  end

  test "should get create" do
    get invitees_create_url
    assert_response :success
  end
end
