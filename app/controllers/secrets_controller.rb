class SecretsController < ApplicationController

	def edit_rules
		admin? do
			render "secrets/edit_rules"
		end
	end

	def update_rules
		admin? do
			rules = Secret.find_by(name: "rules")
			rules.content = rules_params[:rules].gsub(/[\n\r]+/,"&&&")
			rules.save
			redirect_to "/users/#{session[:user_id]}"
		end
	end

	def edit_code
		admin? do
			render "secrets/edit_code"
		end
	end

	def update_code
		admin? do
			code = Secret.find_by(name: "code")
			code.content = code_params[:code]
			code.save
			redirect_to "/users/#{session[:user_id]}"
		end
	end

	private
	def code_params
		params.require(:secrets).permit(:code)
	end

	def rules_params
		params.require(:secrets).permit(:rules)
	end
end