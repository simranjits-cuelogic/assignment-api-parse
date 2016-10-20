class SessionsController < ApplicationController
  before_filter :check_for_login, only: [
    :login, :create_login, :signup, :create_signup
  ]

  def login ; end

  def create_login
    if (@user = User.authenticate_user_for params[:user][:email], params[:user][:password])
      login_user
      redirect_to root_path, notice: 'Successfully loggedIn.'
    else
      redirect_to login_sessions_path, alert: 'Invalid login creadentionals.'
    end
  end

  def signup
    @user = User.new
  end

  def create_signup
    @user = User.new(user_params)
    if @user.save
      login_user
      redirect_to root_path, notice: 'Successfully loggedIn.'
    else
      render 'signup'
    end
  end

  def logout
    clear_session
    redirect_to login_sessions_path, notice: 'Successfully logged Out.'
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :city, :name)
  end

  def login_user
    # todo: change it later with MD5
    session[:user_id] = @user.id
  end

  def check_for_login
    redirect_to root_path, notice: 'You are already logged In.' if current_user
  end

end
