require 'test_helper'

class SigninUserTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password")
  end

  test "sign in exisiting user" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "john@example.com", password: "password" } }
    follow_redirect!
    assert_template 'users/show'
    assert_match "john", response.body
  end

  test "sign in non existing user" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "bob@example.com", password: "password" } }
    assert_template 'sessions/new'
    assert_no_match "bob", response.body
  end

end
