require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin    = users(:admin)
    @active   = users(:customer_active)
    @other    = users(:other_active)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@active)
    refute flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@active), params: { user: { name:  @active.name,
                                              email: @active.email } }
    refute flash.empty?
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@active)
    refute @active.admin?
    patch user_path(@active), params: {
                                    user: { password: "password",
                                            password_confirmation: "password",
                                            admin: true } }
    refute @active.reload.admin?
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other)
    get edit_user_path(@active)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other)
    patch user_path(@active), params: { user: { name:  @active.name,
                                              email: @active.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@active)
    end
    assert_redirected_to login_url
  end

end
