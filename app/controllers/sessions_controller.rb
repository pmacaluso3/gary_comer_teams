class SessionsController < ApplicationController
	def new
		logged_in? do
			redirect_to "/users/#{session[:user_id]}"
		end
	end

	def create
		@user = User.find_by(email: session_params[:email])
		if @user && @user.authenticate(session_params[:password])
			session[:user_id] = @user.id
			redirect_to "/users/#{@user.id}"
		else
			@errors = "There was an error logging in."
			render "sessions/new"
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to "/sessions/new"
	end

	private
	def session_params
		params.require(:session).permit(:email, :password)
	end
end