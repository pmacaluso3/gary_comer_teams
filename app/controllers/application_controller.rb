class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in?
  	if session[:user_id]
  		yield
  	else
  		redirect_to '/sessions/new'
  	end
  end
end
