class WelcomeController < ApplicationController
	def index
		logged_in? do
			@user = User.find_by(id:session[:user_id])
			redirect_to "/users/#{@user.id}"
		end
	end
end