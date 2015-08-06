class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :get_rules

  def get_rules
    @rules = Secret.find_by(name: "rules")
  end

  def logged_in?
  	if session[:user_id] && User.find_by(id: session[:user_id])
  		yield
  	else
  		render '/sessions/new'
  	end
  end

  def admin?
    if session[:user_id] && User.find_by(id:session[:user_id]).admin
      yield
    else
      redirect_to '/sessions/new'
    end
  end
end
