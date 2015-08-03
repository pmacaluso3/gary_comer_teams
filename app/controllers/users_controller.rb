class UsersController < ApplicationController
	def show
		logged_in? do
			@user = User.find_by(id: session[:user_id])
		end
	end

	# This will later be the method to show all teachers' teams
	def index
		redirect_to "/sessions/new"
	end

	def create
		if params[:user][:code] != "teacher code"
			@errors = "Incorrect teacher code"
			render "/sessions/new"
		else
			@user = User.new(user_params)
			if @user.save
				session[:user_id] = @user.id
				redirect_to "/users/#{@user.id}"
			else
				@errors = []
				@user.errors.messages.each do |field, message|
					@errors << "#{field.capitalize} #{message[0]}."
				end
				render "/sessions/new"
			end
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :password)
	end
end