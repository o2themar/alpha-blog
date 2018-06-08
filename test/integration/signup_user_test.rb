require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password")
  end

  test "sign up new user" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "bob", email: "bob@example.com", password: "password" } }
      follow_redirect!
    end
    assert_template 'users/show'
    assert_match "bob", response.body
  end

  test "sign up existing user" do
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "john", email: "john@example.com", password: "password" } }
    end
    assert_template 'users/new'
  end

end
