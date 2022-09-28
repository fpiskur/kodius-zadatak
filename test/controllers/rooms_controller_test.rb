require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @room = rooms(:one)
  end

  test "should redirect index when not logged in" do
    get rooms_path
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    get rooms_path(@room)
    assert_redirected_to login_url
  end

end
