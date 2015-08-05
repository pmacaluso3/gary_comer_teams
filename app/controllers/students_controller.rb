class StudentsController < ApplicationController
	def new
		admin? do

		end
	end

	def create
		puts "********************* #{params.inspect}"
	end
end