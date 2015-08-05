require 'csv'

class StudentsController < ApplicationController
	def new
		admin? do

		end
	end

	def create
		split_student_lines = []
		# File.open(filename) do |f|
		# 	student_data = f.read
		# 	student_lines = student_data.split("\n")
		# 	student_lines.each do |l|
		# 		split_student_lines << l.split(/[,+\ +]/).reject{|e|e==""}
		# 	end
		# end

		student_lines = student_data.split(/[\r\n]+/)
		student_lines.each do |l|
			split_student_lines << l.split(/[,+\ +]/).reject{|e|e==""}
		end

		# CSV.foreach(filename.path) do |row|
		# 	puts row.inspect
		# end

		
		
		puts "*************************** #{student_lines}"
		puts "*************************** #{split_student_lines}"

		render "students/index"
	end

	private

	def student_data
		params.require(:students).permit(:students)[:students]
	end

	def filename
		params.require(:students).permit(:students)[:students]
	end
end