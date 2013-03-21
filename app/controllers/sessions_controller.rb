class SessionsController < ApplicationController

  before_filter CASClient::Frameworks::Rails::Filter, only: :validate

  def new
    session[:attempted_url] ||= root_url
  end

  def create
    credentials = { username: params[:login][:username], 
                    password: params[:login][:password] }
    client = CASClient::Frameworks::Rails::Filter
    response = client.login_to_service(self, credentials, validate_login_url)

    unless response.failure_message.blank?
      flash[:error] = response.failure_message
      render 'new'
    else
      session[:attempted_url] = nil
      redirect_to response.service_redirect_url
    end
  end

  def destroy
    CASClient::Frameworks::Rails::Filter.logout(self, root_url) and return
  end

  def validate
    if session[:attempted_url]
      redirect_to session[:attempted_url]
    else
      redirect_to root_url
    end
  end

  def login_required?
    false
  end
end
