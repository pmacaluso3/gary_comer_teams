class UsersController < ApplicationController
	def show
		logged_in? do
			@user = User.find_by(id: session[:user_id])
			@students = @user.students
			if @students.length > 0
				@avg_gpa = @students.reduce(0){|acc,s|acc += s.gpa}/@students.length.to_f.round(2)
				@total_detentions = @students.reduce(0){|acc,s|acc += s.detention_count}.to_f.round(2)
				@avg_detentions = @total_detentions/@students.length.to_f.round(2)
				@percent_male = @students.select{|s|s.gender == "M"}.length/@students.length.to_f.round(2)*100
				@percent_female = @students.select{|s|s.gender == "F"}.length/@students.length.to_f.round(2)*100
			end
			@yours = true if session[:user_id].to_s == params[:id]
		end
	end

	# This will later be the method to show all teachers' teams
	def index
		logged_in? do
			@users = User.order(:last_name)
		end
	end

	def edit
		logged_in? do
			@user = User.find_by(id: session[:user_id])
		end
	end

	def update
		logged_in? do
			if params[:user][:code] != Secret.find_by(name: "code").content
				@errors = "Incorrect teacher code"
				@user = User.find_by(id:session[:user_id])
				render "/users/edit"
			else
				@user = User.find_by(id: session[:user_id])
				if @user.update(user_params)
					session[:user_id] = @user.id
					redirect_to user_path(@user)
				else
					@errors = []
					@user.errors.messages.each do |field, message|
						@errors << "#{field.capitalize} #{message[0]}."
					end
					render "/users/edit"
				end
			end
		end
	end

	def create
		if params[:user][:code] != Secret.find_by(name: "code").content
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
		params.require(:user).permit(:email, :password, :first_name, :last_name)
	end
end