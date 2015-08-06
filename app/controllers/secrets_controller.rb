class SecretsController < ApplicationController

	def edit_rules
		admin? do
			render "secrets/edit_rules"
		end
	end

	def update_rules
		admin? do
			
		end
	end

	def edit_code
		admin? do
			render "secrets/edit_code"
		end
	end

	def update_code
		admin? do
			
		end
	end
end