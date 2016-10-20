require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:valid)
    @auth_user = users(:auth)
  end

  test "should get signup new" do
    get :signup
    assert_response :success
  end

  test 'should not create user with duplicate email' do
    assert_no_difference("User.count") do
      post :create_signup, user: {name: @user.name, email: 'dummy@dummy.com',
        password: @user.password_digest, password_confirmation: @user.password_digest, city: @user.city}
    end
    assert_response :success
  end

  test 'should not create user without email' do
    assert_no_difference("User.count") do
      post :create_signup, user: {name: @user.name, password: @user.password_digest,
        password_confirmation: @user.password_digest, city: @user.city}
    end
    assert_response :success
  end

  test 'should not create user without name' do
    assert_no_difference("User.count") do
      post :create_signup, user: {email: 'new@user.com', password: @user.password_digest,
        password_confirmation: @user.password_digest, city: @user.city}
    end
    assert_response :success
  end

  test 'should not create user without city' do
    assert_no_difference("User.count") do
      post :create_signup, user: {name: @user.name, email: 'new@user.com', password: @user.password_digest,
        password_confirmation: @user.password_digest}
    end
    assert_response :success
  end

  test 'should create user' do
    assert_difference("User.count", 1) do
      post :create_signup, user: {name: @user.name, email: 'new@user.com',
        password: @user.password_digest, password_confirmation: @user.password_digest, city: @user.city}
    end
    assert_redirected_to root_path
    # should log in
    assert is_logged_in?
  end

  # test cases for session login

  test "should get login new" do
    get :login
    assert_response :success
  end

  test "login with invalid information" do

    post :create_login, user: {
      email: @auth_user.email,
      password: 'wrong-pass-correct-is-aaaaaaaa'
    }
    # should not log in
    assert_not is_logged_in?
    assert_redirected_to login_sessions_path
    assert_not flash.empty?
  end

  test "login with valid information" do
    get :login

    post :create_login, user: {
      email: @auth_user.email,
      password: 'aaaaaaaa'
    }
    # should log in
    assert is_logged_in?
    assert_redirected_to root_path
  end

  # sessions logout
  test 'should logout' do
    delete :logout
    assert_not is_logged_in?, 'User should not be logged in here.'
    assert_redirected_to login_sessions_path
  end


end
