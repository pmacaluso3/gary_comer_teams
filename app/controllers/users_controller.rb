class UsersController < ApplicationController
	def show
		logged_in? do
			@user = User.find_by(id: session[:user_id])
		end
	end
end