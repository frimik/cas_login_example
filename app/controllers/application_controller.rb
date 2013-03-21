class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_for_login, :if => :login_required?

  helper :all
  helper_method :current_user

  def current_user
    session[:cas_extra_attributes]
  end

  def login_required?
    true
  end

  def check_for_login
    if current_user.nil?
      session[:attempted_url] = request.url
      redirect_to login_path
    end
  end
end
