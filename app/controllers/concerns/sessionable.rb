module Sessionable
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]

    rescue ActiveRecord::RecordNotFound
      clear_session
      false
  end

  def authorize
    redirect_to login_sessions_path unless current_user
  end

  def clear_session
    session[:user_id] = nil
    @current_user = nil
  end

  module ClassMethods ; end
end