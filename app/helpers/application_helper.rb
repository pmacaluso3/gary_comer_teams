module ApplicationHelper
	def admin?
    if session[:user_id] && User.find_by(id:session[:user_id]).admin
      yield
		end
	end
end
